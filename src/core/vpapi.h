#ifndef VPAPI_H
#define VPAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QScopedPointer>

#include "vpresponse.h"

// Default server (Vertretungsplan mirror for OurGUS)
const char* const DEFAULT_BASE_URL = "https://vp.timsueberkrueb.io";

#ifdef OURGUS_API_FALLBACK_BASE_URL
    const char* const FALLBACK_BASE_URL = OURGUS_API_FALLBACK_BASE_URL;
#else
    const char* const FALLBACK_BASE_URL = "";
#endif

class VPApi : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl defaultBaseUrl READ defaultBaseUrl)
    Q_PROPERTY(QUrl fallbackBaseUrl READ fallbackBaseUrl)
    Q_PROPERTY(QUrl baseUrl READ baseUrl WRITE setBaseUrl NOTIFY baseUrlChanged)
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
public:
    explicit VPApi(QObject *parent = nullptr);

    Q_INVOKABLE bool checkConnection(const QString& endpoint = "connectivity_check");

    QUrl defaultBaseUrl() const { return QUrl(DEFAULT_BASE_URL); }
    QUrl fallbackBaseUrl() const { return QUrl(FALLBACK_BASE_URL); }

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
