import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import Fluid.Controls 1.0

Page {
    id: page

    visible: false
    title: "Über"

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

    Flickable {
        anchors {
            fill: parent
        }

        contentHeight: columnLayout.height + Units.mediumSpacing * 2

        ColumnLayout {
            id: columnLayout

            x: Units.mediumSpacing
            y: Units.mediumSpacing
            width: parent.width - Units.mediumSpacing * 2

            spacing: Units.smallSpacing

            TitleLabel {
                text: "OurGUS"
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font.pixelSize: 16
                text: "OurGus ist eine inoffizielle App für das Gymnasium Unterrieden Sindelfingen."
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font.pixelSize: 16
                text: "Das Anwendungsicon wurde von Hendrik Süberkrüb erstellt, vielen Dank!"
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font.pixelSize: 16
                text: "OurGus ist open-source und steht unter der GPL Lizenz (Version 3). Der Quellcode ist öffentlich auf GitHub einsehbar."
            }

            Row {
                spacing: Units.mediumSpacing

                Button {
                    text: "GitHub"
                    onClicked: Qt.openUrlExternally("http://github.com/tim-sueberkrueb/ourgus")
                }

                Button {
                    text: "Kontakt"
                    onClicked: Qt.openUrlExternally("https://timsueberkrueb.io")
                }
            }

            ThinDivider {
                Layout.fillWidth: true
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "<b>YourGUS ist eine inoffizielle Anwendung</b> für Schüler des <a href='http://www.gymnasium-unterrieden.de/'>Gymnasium Unterrieden Sindelfingen</a>. "+
                      "Diese App wird weder durch das Gymnasium Unterrieden, die Schulleitung oder die Stadt Sindelfingen "+
                      "unterstützt noch wird sie offiziell von genannten Einrichtungen bzw. Personengruppen zur Verfügung gestellt. "
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "<b>Verantwortlich für den Inhalt nach § 55 Abs. 2 RStV:</b><br/>" +
                      "Tim Süberkrüb. Im Rahmen dieser Anwendung veröffentlichte Meinungsäußerungen " +
                      "(in Form von Videos, Kommentaren, Blogposts und anderen Inhalten) spiegeln " +
                      "- wenn nicht anders gekennzeichnet - lediglich meine persönliche Meinung wieder. " +
                      "Die Inhalte werden mit angemessener Sorgfalt erstellt, jedoch übernehme ich ausdrücklich keine Gewähr für die Richtigkeit, Vollständigkeit " +
                      " und Aktualität der Inhalte."
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "Auf die Aktualität, Richtigkeit und Vollständigkeit der Vertretungsplaninhalte habe ich keinen Einfluss und übernehme somit keine Gewähr. "+
                      "Das gilt ebenso für alle eingebettete Webseiten."
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "<b>YourGus ist freie Software</b> und steht unter der <a href='https://www.gnu.org/licenses/gpl'>GNU General Public License (Version 3)</a> zur Verfügung."
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: 'This program is distributed in the hope that it will be useful,'+
                      ' but WITHOUT ANY WARRANTY; without even the implied warranty of'+
                      ' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'+
                      ' GNU General Public License for more details.'
            }

            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "Copyright © 2017 by Tim Süberkrüb"
            }
        }
    }
}
