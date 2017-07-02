import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0

Page {
    id: page

    property url url
    readonly property bool active: StackView.view ? StackView.view.currentItem === page : false

    property int student: 0
    property int teacher: 1
    property alias userType: comboType.currentIndex
    property string form
    property alias name: fieldName.text

    // Hide default app bar
    appBar.visible: false
    visible: false
    title: "Optionen"

    header: ToolBar {
        RowLayout {
            anchors {
                fill: parent
                rightMargin: Units.smallSpacing
            }

            IconButton {
                iconColor: "white"
                iconName: "navigation/arrow_back"
                onClicked: {
                    page.pop();
                }
            }

            TitleLabel {
                color: "white"
                text: page.title
            }

            Item { Layout.fillWidth: true }     // Spacer
        }
    }

    RowLayout {
        anchors {
            fill: parent
            margins: Units.mediumSpacing
        }

        GridLayout {
            Layout.fillHeight: true

            columns: 2
            rowSpacing: Units.smallSpacing
            columnSpacing: Units.smallSpacing

            Label {
                text: "Ich bin"
            }

            ComboBox {
                id: comboType
                model: ["Schüler", "Lehrer"]
            }

            Label {
                visible: userType == teacher
                text: "Name"
            }

            TextField {
                id: fieldName
                visible: userType == teacher
            }

            Item {
                visible: userType == teacher
                width: 1
            } // Spacer

            Label {
                Layout.fillWidth: true
                visible: userType == teacher
                text: "Geben Sie Ihren Namen so an, wie er im Änderungsplan angezeigt wird."
                wrapMode: Text.WordWrap
            }

            Label {
                visible: userType == student
                text: "Klasse"
            }

            Row {
                visible: userType == student

                spacing: Units.smallSpacing

                ComboBox {
                    id: comboFormGrade

                    property bool loaded: false

                    currentIndex: -1
                    model: [
                        "5",
                        "6",
                        "7",
                        "8",
                        "9",
                        "10",
                        "11",
                        "12"
                    ]
                    onCurrentTextChanged: {
                        if (loaded) {
                            if (currentText == "11" || currentText == "12") {
                                form = currentText;
                            } else {
                                var formSect = form[form.length-1];
                                form = currentText + formSect;
                            }
                        }
                    }
                    Component.onCompleted: {
                        if (form !== "") {
                            if (form === "11" || form === "12") {
                                currentIndex = model.indexOf(form);
                            } else {
                                currentIndex = model.indexOf(form.slice(0, form.length-1));
                            }
                        }
                        loaded = true;
                    }
                }

                ComboBox {
                    id: comboFormSect

                    property bool loaded: false

                    visible: comboFormGrade.currentText !== "11"
                             && comboFormGrade.currentText !== "12"
                    model: ["a", "b", "c", "d"]
                    currentIndex: -1

                    onCurrentTextChanged: {
                        if (loaded) {
                            form = form.slice(0, form.length-1) + currentText;
                        }
                    }
                    Component.onCompleted: {
                        if (form !== "") {
                            if (form !== "11" && form !== "12") {
                                currentIndex = model.indexOf(form[form.length-1]);
                            }
                        }
                        loaded = true;
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }

        Item { Layout.fillWidth: true }     // Spacer
    }
}
