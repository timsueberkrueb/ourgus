import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0
import Fluid.Core 1.0
import VP 0.1

Page {
    id: page

    property list<VPDate> dates
    property VPDate currentDate
    property var dateStrings: []
    property list<Action> drawerActions

    property int student: 0
    property int teacher: 1
    property int userType
    property string name
    property string form

    property bool filter: false

    function load(response) {
        dateStrings = [];
        dates = response.dates;
        for (var i=0; i<dates.length; i++) {
            dateStrings.push(dates[i].prettyDate);
        }
        dateStringsChanged();
    }

    signal optionsRequested

    onCurrentDateChanged: {
        planView.positionViewAtBeginning();
    }

    // Hide default app bar
    appBar.visible: false

    header: ToolBar {
        RowLayout {
            anchors {
                fill: parent
                rightMargin: Units.smallSpacing
            }

            IconButton {
                iconColor: "white"
                iconName: "navigation/menu"
                onClicked: {
                    navigationDrawer.open();
                }
            }

            TitleLabel {
                Layout.fillWidth: true
                text: "Plan"
                color: "white"
            }

            Item { Layout.fillWidth: true }     // Spacer

            Item {
                implicitHeight: parent.height
                implicitWidth: 36

                IconButton {
                    id: refreshButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: !api.loading
                    iconColor: "white"
                    iconName: "navigation/refresh"
                    onClicked: {
                        api.fetch();
                    }
                }

                BusyIndicator {
                    anchors.centerIn: refreshButton
                    implicitHeight: 36
                    implicitWidth: 36
                    running: api.loading
                    visible: running
                    Material.accent: "white"
                }
            }

            ComboBox {
                model: dateStrings
                onCurrentIndexChanged: {
                    if (dates[currentIndex]) {
                        currentDate = dates[currentIndex];
                    }
                }
            }
        }
    }

    NavigationDrawer {
       id: navigationDrawer

       dragMargin: page.visible ? Qt.styleHints.startDragDistance : 0

       width: 256
       height: parent.height
       edge: Qt.LeftEdge

       topContent: HeadlineLabel {
           Layout.margins: Units.mediumSpacing

           text: "OurGUS"
       }

       actions: drawerActions
    }

    Flickable {
        anchors.fill: parent

        contentHeight: columnLayout.height

        Column {
            id: columnLayout
            width: parent.width
            height: childrenRect.height

            ListItem {
                visible: infoLabel.available ||
                         absentFormsLabel.available ||
                         absentTeachersLabel.available ||
                         missingRoomsLabel.available

                width: parent.width
                height: infoColumn.height + Units.mediumSpacing * 2

                Column {
                    id: infoColumn

                    x: Units.mediumSpacing
                    y: Units.mediumSpacing
                    width: parent.width - Units.mediumSpacing * 2
                    height: childrenRect.height

                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        text: "<b>Informationen</b>"
                    }

                    Label {
                        id: infoLabel
                        property bool available: text
                        visible: available
                        width: parent.width
                        wrapMode: Text.WordWrap
                        text: userType === student
                              ? currentDate.studentNotes
                              : currentDate.teacherNotes
                    }

                    Label {
                        id: absentFormsLabel
                        property bool available: userType === teacher && currentDate.absentForms
                        visible: available
                        width: parent.width
                        wrapMode: Text.WordWrap
                        text: "Abwesende Klassen: %1".arg(currentDate.absentForms)
                    }

                    Label {
                        id: absentTeachersLabel
                        property bool available: userType === teacher && currentDate.absentTeachers
                        visible: available
                        width: parent.width
                        wrapMode: Text.WordWrap
                        text: "Abwesende Lehrer: %1".arg(currentDate.absentTeachers)
                    }

                    Label {
                        id: missingRoomsLabel
                        property bool available: userType === teacher && currentDate.missingRooms
                        visible: available
                        width: parent.width
                        wrapMode: Text.WordWrap
                        text: "Belegte Räume: %1".arg(currentDate.missingRooms)
                    }
                }

                ThinDivider {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                }
            }

            ListItem {
                visible: planView.model.count === 0
                width: parent.width

                iconName: "action/check_circle"
                text: "Bislang keine Änderungen"
            }

            ListView {
                id: planView

                width: parent.width
                height: contentHeight

                interactive: false
                model: SortFilterProxyModel {
                    filterRoleName: userType === student ? "form" : "substitutionTeacher"
                    filterExpression: {
                        if (!filter) {
                            return true;
                        }else if (userType === student) {
                            if (form === "") {
                                return true;
                            } else if (form === "12") {
                                return (model.form === "12" || model.form === "Abi");
                            } else if (form === "11") {
                                return model.form.indexOf("11") === 0;
                            } else {
                                var formGrade = form.slice(0, form.length-1);
                                var formSect = form[form.length-1];
                                return model.form === form.toLowerCase()
                                        || (model.form.toLowerCase().indexOf(formGrade) === 0
                                            && model.form.toLowerCase().indexOf(formSect) > 0);
                            }
                        } else if (userType === teacher) {
                            if (name === "") {
                                return true;
                            } else {
                                return (model.substitutionTeacher === name || model.originalTeacher === name);
                            }
                        }
                        return true;
                    }
                    sourceModel: VPEntriesModel {
                        entries: currentDate ? currentDate.entries : []
                    }
                }
                delegate: BaseListItem {
                    height: {
                        if (noteLabel.visible && teacherLabel.visible) {
                            return 76;
                        } else if (noteLabel.visible || teacherLabel.visible) {
                            return 64;
                        } else {
                            return 48;
                        }
                    }

                    RowLayout {
                        anchors {
                            fill: parent
                            leftMargin: Units.mediumSpacing
                            rightMargin: Units.mediumSpacing
                        }
                        spacing: Units.mediumSpacing

                        Rectangle {
                            implicitHeight: 32
                            implicitWidth: 32
                            radius: width/2

                            color: {
                                if (model.substitutionTeacher === "entfällt") {
                                    return Material.color(Material.Red);
                                } else if (model.substitutionSubject === "Aufs.") {
                                    return Material.color(Material.Green);
                                } else if (model.note === "Raumänderung") {
                                    return Material.color(Material.Blue);
                                } else {
                                    return Material.color(Material.Orange);
                                }
                            }

                            Label {
                                anchors.centerIn: parent
                                color: "white"
                                text: model ? model.lesson.toString() + "." : ""
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true

                            RowLayout {
                                Layout.fillHeight: true

                                spacing: Units.mediumSpacing


                                Label {
                                    text: {
                                        if (model.substitutionTeacher === "entfällt") {
                                            return "%1 entfällt".arg(model.originalSubject);
                                        } else {
                                            return (
                                                model.note === "Raumänderung"
                                                    ? ""
                                                    : "Statt %1: "
                                                      .arg(model.originalSubject))
                                                + "%2 in %3"
                                                    .arg(model.substitutionSubject)
                                                    .arg(model.substitutionRoom);
                                        }
                                    }
                                }

                                Item { Layout.fillWidth: true } // Spacer

                                Label {
                                    text: model ? model.form : ""
                                }

                            }

                            Label {
                                id: teacherLabel
                                visible: model.substitutionTeacher !== "entfällt" &&
                                         (model.note === "—" || model.substitutionTeacher !== "—")

                                text: "bei %3".arg(
                                     model.substitutionTeacher === "—"
                                         ? model.originalTeacher
                                         : model.substitutionTeacher
                                 )
                            }

                            Label {
                                id: noteLabel
                                visible: model.note !== "—"
                                text: model.note
                                font.italic: true
                            }
                        }
                    }
                }
            }
        }
    }

    ActionButton {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: Units.mediumSpacing
        }

        Material.background: Material.accent

        iconName: filter ? "navigation/cancel" : "content/filter_list"

        onClicked: {
            if ((form === "" && userType === student) || (name === "" && userType === teacher)) {
                optionsRequested();
                return;
            }
            filter = !filter;
            if (filter) {
                infoBar.open("Zeige nur Einträge, die dich direkt betreffen.");
            } else {
                infoBar.open("Zeige alle Einträge.");
            }
        }
    }

    VPApi {
        id: api
        onError: {
            console.warn("Network error:", errorString);
            infoBar.open("Ein Netzwerkfehler ist aufgetreten. Überprüfe deine Internetverbindung.");
        }
        onReceived: {
            load(response);
            cache.save(response);
        }
    }

    VPCache { id: cache }

    InfoBar { id: infoBar; duration: 3000 }

    Component.onCompleted: {
        var cachedResponse = cache.load();
        if (cachedResponse) {
            load(cachedResponse);
        }
        api.fetch();
    }
}
