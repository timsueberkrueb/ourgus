#include "vpdate.h"

VPDate::VPDate(QObject *parent)
    : QObject(parent)
{

}

void VPDate::loadJson(const QJsonObject &object)
{
    const QString dateFormat = QStringLiteral("yyyy-MM-ddTHH:mm:ss");
    emit dateChanged(_date = QDateTime::fromString(object["date"].toString(), dateFormat));
    emit prettyDateChanged(prettyDate());
    emit versionChanged(_version = object["version"].toInt());
    emit lastUpdatedChanged(_lastUpdated = QDateTime::fromString(object["lastUpdated"].toString(), dateFormat));
    emit prettyLastUpdatedChanged(prettyLastUpdated());
    emit studentNotesChanged(_studentNotes = object["studentNotes"].toString());
    emit teacherNotesChanged(_teacherNotes = object["teacherNotes"].toString());
    emit absentFormsChanged(_absentForms = object["absentForms"].toString());
    emit missingRoomsChanged(_missingRooms = object["missingRooms"].toString());
    _entries.clear();
    auto jsonEntries = object["entries"].toArray();
    QJsonArray::const_iterator i;
    for (i=jsonEntries.constBegin(); i != jsonEntries.constEnd(); i++) {
        const QJsonObject jsonEntry = (*i).toObject();
        VPEntry* entry = new VPEntry(this);
        entry->loadJson(jsonEntry);
        _entries.append(QVariant::fromValue(entry));
    }
}
