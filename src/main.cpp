#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QtWebView>

#include "core/vpapi.h"
#include "core/vpcache.h"
#include "core/vpentriesmodel.h"
#include "core/vpresponse.h"
#include "core/vpdate.h"
#include "core/vpentry.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setApplicationName("ourgus");

    QtWebView::initialize();

    QQuickStyle::setStyle(QStringLiteral("Material"));

    qmlRegisterType<VPApi>("VP", 0, 1, "VPApi");
    qmlRegisterType<VPCache>("VP", 0, 1, "VPCache");
    qmlRegisterType<VPEntriesModel>("VP", 0, 1, "VPEntriesModel");
    qmlRegisterUncreatableType<VPResponse>("VP", 0, 1, "VPResponse", "Type \"VPResponse\" may not be created directly");
    qmlRegisterUncreatableType<VPDate>("VP", 0, 1, "VPDate", "Type \"VPDate\" may not be created directly");
    qmlRegisterUncreatableType<VPEntry>("VP", 0, 1, "VPEntry", "Type \"VPEntry\" may not be created directly");

    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral("qrc:/"));
    engine.load(QUrl(QStringLiteral("qrc:///ui/Main.qml")));

    return app.exec();
}
