#include <QDebug>

#include "vpcache.h"

VPCache::VPCache(QObject *parent)
    : QObject(parent),
    _cachePath(QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation)),
    _cacheDir(_cachePath)
{
    if (!_cacheDir.exists()) {
        _cacheDir.mkpath(_cachePath);
    }
}

VPResponse *VPCache::load()
{
    QFile file(_cachePath + QStringLiteral("/") + _cacheFileName);
    if (!file.exists() || !file.open(QIODevice::ReadOnly)) {
        qWarning() << "Couldn't open cache file: " << _cachePath + QStringLiteral("/") + _cacheFileName;
        return nullptr;
    }
    auto data = file.readAll();
    auto response = new VPResponse(this);
    response->loadJson(data);
    file.close();
    return response;
}

void VPCache::save(VPResponse *response)
{
    QFile file(_cachePath + QStringLiteral("/") + _cacheFileName);
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Couldn't open cache file: " << (_cachePath + QStringLiteral("/") + _cacheFileName);
        return;
    }
    auto data = response->json();
    file.write(data);
    file.close();
}
