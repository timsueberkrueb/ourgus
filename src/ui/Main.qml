import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import Fluid.Controls 1.0

ApplicationWindow {
    id: window

    Material.primary: Material.color(Material.DeepOrange)
    Material.accent: Material.color(Material.Orange)

    title: "OurGUS"
    width: 640
    height: 480

    header: Item {}

    PageStack {
        id: pageStack

        anchors.fill: parent

        initialItem: PlanPage {
            id: planPage

            userType: options.userType
            name: options.name
            form: options.form

            onOptionsRequested: {
                pageStack.push(optionsPage);
            }

            drawerActions: [
                Action {
                    text: "Mensa"
                    icon.source: Utils.iconUrl("maps/restaurant")
                    onTriggered: {
                        source.close();
                        pageStack.push(mensaPage);
                    }
                },
                Action {
                    text: "News"
                    icon.source: Utils.iconUrl("av/new_releases")
                    onTriggered: {
                        source.close();
                        pageStack.push(newsPage);
                    }
                },
                Action {
                    text: "Optionen"
                    icon.source: Utils.iconUrl("action/settings")
                    onTriggered: {
                        source.close();
                        pageStack.push(optionsPage);
                    }
                },
                Action {
                    text: "Über"
                    icon.source: Utils.iconUrl("action/info")
                    onTriggered: {
                        source.close();
                        pageStack.push(aboutPage);
                    }
                }
            ]
        }

        WebViewPage {
            id: mensaPage
            url: "https://gus.sams-on.de/"
        }

        WebViewPage {
            id: newsPage
            url: "http://www.gymnasium-unterrieden.de/"
        }

        OptionsPage {
            id: optionsPage
        }

        AboutPage {
            id: aboutPage
        }
    }

    Settings {
        id: options

        property alias name: optionsPage.name
        property alias form: optionsPage.form
        property alias userType: optionsPage.userType

        category: "options"
    }

    Settings {
        property alias filter: planPage.filter

        category: "plan"
    }

    Component.onCompleted: {
        show();
    }
}
