#ifndef VPAPI_H
#define VPAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QScopedPointer>

#include "vpresponse.h"

#ifdef OURGUS_API_BASE_URL
    const char* const DEFAULT_BASE_URL = OURGUS_API_BASE_URL;
#else
    const char* const DEFAULT_BASE_URL = "";
#endif


class VPApi : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl baseUrl READ baseUrl WRITE setBaseUrl NOTIFY baseUrlChanged)
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
public:
    explicit VPApi(QObject *parent = nullptr);

    void setBaseUrl(const QUrl& baseUrl) { baseUrlChanged(_baseUrl = baseUrl); }
    QUrl baseUrl() const { return _baseUrl; }

    bool loading() const { return _loading; }

    Q_INVOKABLE void fetch();

signals:
    void baseUrlChanged(const QUrl& baseUrl);
    void loadingChanged(bool loading);
    void error(QString errorString);
    void received(VPResponse* response);

private:
    QScopedPointer<QNetworkAccessManager> _networkManager;
    QUrl _baseUrl { DEFAULT_BASE_URL };
    bool _loading { false };

};

#endif // VPAPI_H
