#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#ifdef USE_QTWEBVIEW
    #include <QtWebView>
#elif USE_QTWEBENGINE
    #include <QtWebEngine>
#endif

#include "core/vpapi.h"
#include "core/vpcache.h"
#include "core/vpentriesmodel.h"
#include "core/vpresponse.h"
#include "core/vpdate.h"
#include "core/vpentry.h"

int main(int argc, char *argv[])
{
    #ifdef Q_OS_LINUX
        // Workaround QtWebEngine crashing on Nouveau:
        // https://bugreports.qt.io/browse/QTBUG-41242
        qputenv("LIBGL_ALWAYS_SOFTWARE", QByteArray("1"));
    #endif

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setApplicationName(QStringLiteral("ourgus"));
    app.setOrganizationName(QStringLiteral("ourgus"));
    app.setOrganizationDomain(QStringLiteral("timsueberkrueb.io"));

    #ifdef USE_QTWEBVIEW
        QtWebView::initialize();
    #elif USE_QTWEBENGINE
        QtWebEngine::initialize();
    #endif

    QQuickStyle::setStyle(QStringLiteral("Material"));

    qmlRegisterType<VPApi>("VP", 0, 1, "VPApi");
    qmlRegisterType<VPCache>("VP", 0, 1, "VPCache");
    qmlRegisterType<VPEntriesModel>("VP", 0, 1, "VPEntriesModel");
    qmlRegisterUncreatableType<VPResponse>("VP", 0, 1, "VPResponse", "Type \"VPResponse\" may not be created directly");
    qmlRegisterUncreatableType<VPDate>("VP", 0, 1, "VPDate", "Type \"VPDate\" may not be created directly");
    qmlRegisterUncreatableType<VPEntry>("VP", 0, 1, "VPEntry", "Type \"VPEntry\" may not be created directly");

    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral("qrc:/"));
    #ifdef USE_QTWEBVIEW
        engine.rootContext()->setContextProperty("WEBVIEW_BACKEND", QVariant("QtWebView"));
    #elif USE_QTWEBENGINE
        engine.rootContext()->setContextProperty("WEBVIEW_BACKEND", QVariant("QtWebEngine"));
    #endif
    engine.load(QUrl(QStringLiteral("qrc:///ui/Main.qml")));

    return app.exec();
}
