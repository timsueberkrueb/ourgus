#ifndef VPDATE_H
#define VPDATE_H

#include <QObject>
#include <QList>
#include <QDateTime>
#include <QJsonObject>
#include <QJsonArray>
#include <QVariant>
#include <QVariantList>

#include "vpentry.h"

using EntryList = QList<VPEntry*>;

class VPDate : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QDateTime date READ date NOTIFY dateChanged)
    Q_PROPERTY(QString prettyDate READ prettyDate NOTIFY prettyDateChanged)
    Q_PROPERTY(QDateTime lastUpdated READ lastUpdated NOTIFY lastUpdatedChanged)
    Q_PROPERTY(QString prettyLastUpdated READ prettyLastUpdated NOTIFY prettyLastUpdatedChanged)
    Q_PROPERTY(unsigned int version READ version NOTIFY versionChanged)
    Q_PROPERTY(QString studentNotes READ studentNotes NOTIFY studentNotesChanged)
    Q_PROPERTY(QString teacherNotes READ teacherNotes NOTIFY teacherNotesChanged)
    Q_PROPERTY(QString absentForms READ absentForms NOTIFY absentFormsChanged)
    Q_PROPERTY(QString absentTeachers READ absentTeachers NOTIFY absentTeachersChanged)
    Q_PROPERTY(QString missingRooms READ missingRooms NOTIFY missingRoomsChanged)
    Q_PROPERTY(QVariantList entries READ entries NOTIFY entriesChanged)

public:
    explicit VPDate(QObject *parent = nullptr);

    void loadJson(const QJsonObject& object);

    QDateTime date() const { return _date; }
    QString prettyDate() const { return _date.toString(QStringLiteral("ddd dd. MMM")); }
    QDateTime lastUpdated() const { return _lastUpdated; }
    QString prettyLastUpdated() const { return _lastUpdated.toString(Qt::SystemLocaleShortDate); }
    unsigned int version() const { return _version; }
    QString studentNotes() const { return _studentNotes; }
    QString teacherNotes() const { return _teacherNotes; }
    QString absentForms() const { return _absentForms; }
    QString absentTeachers() const { return _absentTeachers; }
    QString missingRooms() const { return _missingRooms; }
    QVariantList entries() const { return _entries; }

signals:
    void dateChanged(const QDateTime& date);
    void prettyDateChanged(const QString& prettyDate);
    void lastUpdatedChanged(const QDateTime& lastUpdated);
    void prettyLastUpdatedChanged(const QString& prettyLastUpdated);
    void versionChanged(const unsigned int version);
    void studentNotesChanged(const QString& studentNotes);
    void teacherNotesChanged(const QString& teacherNotes);
    void absentFormsChanged(const QString& absentForms);
    void absentTeachersChanged(const QString& absentTeachers);
    void missingRoomsChanged(const QString& missingRoomsChanged);
    void entriesChanged(const QVariantList& entries);

private:
    QDateTime _date;
    unsigned int _version;
    QDateTime _lastUpdated;
    QString _studentNotes;
    QString _teacherNotes;
    QString _absentForms;
    QString _absentTeachers;
    QString _missingRooms;
    QVariantList _entries;

};

#endif // VPDATE_H
