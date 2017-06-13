#ifndef VPRESPONSE_H
#define VPRESPONSE_H

#include <QObject>
#include <QList>
#include <QJsonDocument>
#include <QJsonArray>
#include <QVariant>
#include <QVariantList>

#include "vpdate.h"

class VPResponse : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList dates READ dates NOTIFY datesChanged)
public:
    explicit VPResponse(QObject *parent = nullptr);

    void loadJson(const QByteArray& json);
    QByteArray json() const { return _json; }

    QVariantList dates() const { return _dates; }

signals:
    void datesChanged(const QVariantList& dates);

private:
    QVariantList _dates;
    QByteArray _json;
};

#endif // VPRESPONSE_H
