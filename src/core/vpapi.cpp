#include "vpapi.h"

VPApi::VPApi(QObject *parent)
    : QObject(parent),
    _networkManager(new QNetworkAccessManager)
{

}

void VPApi::fetch()
{
    emit loadingChanged(_loading = true);
    QUrl url = QUrl(_baseUrl.toString() + "/dates");
    QNetworkRequest request;
    request.setUrl(url);
    QNetworkReply* reply = _networkManager->get(request);
    connect(reply, &QNetworkReply::finished,
            this, [reply, this](){
        if (reply->error() != QNetworkReply::NoError) {
            emit error(reply->errorString());
        } else {
            VPResponse* response = new VPResponse(this);
            response->loadJson(reply->readAll());
            emit received(response);
        }
        delete reply;
        emit loadingChanged(_loading = false);
    });
}
