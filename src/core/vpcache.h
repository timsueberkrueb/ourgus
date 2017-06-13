#ifndef VPCACHE_H
#define VPCACHE_H

#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

#include "vpresponse.h"

const char* const CACHE_FILE_NAME = "vpcache0.json";

class VPCache : public QObject
{
    Q_OBJECT
public:
    explicit VPCache(QObject *parent = nullptr);

    Q_INVOKABLE VPResponse* load();
    Q_INVOKABLE void save(VPResponse* response);

private:
    QString _cachePath;
    QString _cacheFileName { CACHE_FILE_NAME };
    QDir _cacheDir;
};

#endif // VPCACHE_H
