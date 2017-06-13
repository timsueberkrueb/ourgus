#ifndef VPAPI_H
#define VPAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QScopedPointer>

#include "vpresponse.h"

const char* const BASE_URL = OURGUS_API_BASE_URL;

class VPApi : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
public:
    explicit VPApi(QObject *parent = nullptr);

    bool loading() const { return _loading; }

    Q_INVOKABLE void fetch();

signals:
    void loadingChanged(bool loading);
    void error(QString errorString);
    void received(VPResponse* response);

private:
    QScopedPointer<QNetworkAccessManager> _networkManager;
    QUrl _baseUrl { BASE_URL };
    bool _loading { false };

};

#endif // VPAPI_H
