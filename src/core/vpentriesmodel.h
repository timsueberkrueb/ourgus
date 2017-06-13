#ifndef VPENTRIESMODEL_H
#define VPENTRIESMODEL_H

#include <QAbstractListModel>

#include "vpentry.h"

#include <QDebug>

class VPEntriesModel : public QAbstractListModel{
    Q_OBJECT
    Q_PROPERTY(QVariantList entries READ entries WRITE setEntries NOTIFY entriesChanged)

    enum Roles {
        Form,
        Lesson,
        OriginalTeacher,
        OriginalSubject,
        SubstitutionSubject,
        SubstitutionTeacher,
        SubstitutionRoom,
        Note
    };

public:
    explicit VPEntriesModel(QObject *parent = nullptr);

    QVariantList entries() const { return _entries; }
    void setEntries(const QVariantList& entries) {
        if (rowCount() > 0) {
            beginRemoveRows(QModelIndex(), 0, rowCount() - 1);
            endRemoveRows();
        }
        if (entries.count() > 0) {
            beginInsertRows(QModelIndex(), 0, entries.count() - 1);
            entriesChanged(_entries = entries);
            endInsertRows();
        }
    }

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent=QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;

signals:
    void entriesChanged(const QVariantList& entries);

private:
    QVariantList _entries;

};

#endif // VPENTRIESMODEL_H
