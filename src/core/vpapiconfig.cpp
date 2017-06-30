#include "vpapiconfig.h"

#include <QDebug>

VPApiConfig::VPApiConfig(QObject *parent) : QObject(parent),
  _configPath(QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation)),
  _configDir(_configPath)
{
    if (!_configDir.exists()) {
        _configDir.mkpath(_configPath);
    }
}

bool VPApiConfig::load()
{
    QString filePath = _configPath + QStringLiteral("/") + _configFileName;
    QFile file(filePath);
    if (!file.exists() || !file.open(QIODevice::ReadOnly)) {
        qWarning() << "Couldn't open api config file:" << filePath;
        return false;
    }
    auto data = file.readAll();
    auto doc = QJsonDocument::fromJson(data);
    if (doc.isEmpty() || doc.isNull()) {
        qWarning() << "Invalid api config file:" << filePath;
        return false;
    }
    baseUrlChanged(_baseUrl = QUrl(doc.object()["api_base_url"].toString()));
    file.close();
    return true;
}
