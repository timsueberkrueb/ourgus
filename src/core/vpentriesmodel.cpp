#include "vpentriesmodel.h"

VPEntriesModel::VPEntriesModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

QVariant VPEntriesModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= _entries.count()) {
        return QVariant();
    }
    QVariant entryVariant = _entries.at(index.row());
    QObject* entryObject = qvariant_cast<QObject*>(entryVariant);
    VPEntry* entry = qobject_cast<VPEntry*>(entryObject);
    switch (role) {
        case Form:
            return QVariant(entry->form());
        case Lesson:
            return QVariant(entry->lesson());
        case OriginalTeacher:
            return QVariant(entry->originalTeacher());
        case OriginalSubject:
            return QVariant(entry->originalSubject());
        case SubstitutionSubject:
            return QVariant(entry->substitutionSubject());
        case SubstitutionTeacher:
            return QVariant(entry->substitutionTeacher());
        case SubstitutionRoom:
            return QVariant(entry->substitutionRoom());
        case Note:
            return QVariant(entry->note());
    }
    return QVariant();
}

int VPEntriesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return _entries.count();
}

QHash<int, QByteArray> VPEntriesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Form] = "form";
    roles[Lesson] = "lesson";
    roles[OriginalTeacher] = "originalTeacher";
    roles[OriginalSubject] = "originalSubject";
    roles[SubstitutionSubject] = "substitutionSubject";
    roles[SubstitutionTeacher] = "substitutionTeacher";
    roles[SubstitutionRoom] = "substitutionRoom";
    roles[Note] = "note";
    return roles;
}
