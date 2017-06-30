#ifndef VPAPICONFIG_H
#define VPAPICONFIG_H

#include <QObject>
#include <QUrl>
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

const char* const CONFIG_FILE_NAME = "vpapiconfig0.json";

class VPApiConfig : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl baseUrl READ baseUrl NOTIFY baseUrlChanged)
public:
    explicit VPApiConfig(QObject *parent = nullptr);

    QUrl baseUrl() const { return _baseUrl; }

    Q_INVOKABLE bool load();

signals:
    void baseUrlChanged(const QUrl& baseUrl);

private:
    QUrl _baseUrl;
    QString _configPath;
    QString _configFileName { CONFIG_FILE_NAME };
    QDir _configDir;

};

#endif // VPAPICONFIG_H
