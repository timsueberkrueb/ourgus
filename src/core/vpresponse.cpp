#include "vpresponse.h"

VPResponse::VPResponse(QObject *parent)
    : QObject(parent)
{

}

void VPResponse::loadJson(const QByteArray &json)
{
    _json = json;
    auto doc = QJsonDocument::fromJson(json);
    auto array = doc.array();
    _dates.clear();
    QJsonArray::const_iterator i;
    for (i = array.constBegin(); i != array.constEnd(); i++) {
        const QJsonObject jsonDate = (*i).toObject();
        VPDate* date = new VPDate(this);
        date->loadJson(jsonDate);
        _dates.append(QVariant::fromValue(date));
    }
    datesChanged(_dates);
}
