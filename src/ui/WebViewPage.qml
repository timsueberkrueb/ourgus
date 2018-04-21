import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0

Page {
    id: page

    property url url
    readonly property bool active: StackView.view ? StackView.view.currentItem === page : false

    onActiveChanged: {
        if (active) {
            if (!webview.initialized) {
                webview.initialize();
            }
            if (webview.url !== url) {
                webview.url = url;
            }
        }
    }

    visible: false

    // Hide default app bar
    appBar.visible: false

    header: ToolBar {
        RowLayout {
            anchors {
                fill: parent
                rightMargin: Units.smallSpacing
            }

            ToolButton {
                icon.color: "white"
                icon.source: Utils.iconUrl("navigation/arrow_back")
                onClicked: {
                    page.pop();
                }
            }

            TitleLabel {
                color: "white"
                text: page.title
            }

            Item { Layout.fillWidth: true }     // Spacer

            Item {
                implicitHeight: parent.height
                implicitWidth: 36

                ToolButton {
                    id: refreshButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: webview.loaded
                    icon.color: "white"
                    icon.source: Utils.iconUrl("navigation/refresh")
                    onClicked: {
                        webview.reload();
                    }
                }

                BusyIndicator {
                    anchors.centerIn: refreshButton
                    implicitHeight: 36
                    implicitWidth: 36
                    running: !webview.loaded
                    visible: running
                    Material.accent: "white"
                }
            }

            ToolButton {
                icon.color: "white"
                icon.source: Utils.iconUrl("action/open_in_new")
                onClicked: {
                    Qt.openUrlExternally(url);
                    webview.stop();
                    webview.url = "about:blank";
                    page.pop();
                }
            }
        }
    }

    WebView {
        id: webview
        anchors.fill: parent
    }
}

