import QtQuick 2.0

Item {
    id: container

    property string backend: WEBVIEW_BACKEND

    property bool initialized: false
    readonly property bool loaded: loadProgress === 100
    readonly property real loadProgress: initialized ? __view.loadProgress : 0
    property url url: initialized ? __view.url : Qt.resolvedUrl()
    property var __view: QtObject { property url url: "" }

    function reload() { __view.reload(); }
    function stop() { __view.stop(); }

    function initialize() {
        var webviewComponent;
        if (backend == "QtWebView") {
            webviewComponent = Qt.createComponent("QtWebView.qml");
        } else if (backend == "QtWebEngine") {
            webviewComponent = Qt.createComponent("QtWebEngineView.qml");
        }
        __view = webviewComponent.createObject(
            container, {"anchors.fill": container}
        );
        initialized = true;
    }

    onUrlChanged: {
        if (__view.url !== url) {
            __view.url = url;
        }
    }

    Connections {
        enabled: initialized
        target: __view
        onUrlChanged: {
            if (url !== container.url) {
                container.url = url;
            }
        }
    }
}
