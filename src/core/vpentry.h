#ifndef VPENTRY_H
#define VPENTRY_H

#include <QObject>
#include <QJsonObject>

class VPEntry : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString form READ form NOTIFY formChanged)
    Q_PROPERTY(unsigned int lesson READ lesson NOTIFY lessonChanged)
    Q_PROPERTY(QString originalTeacher READ originalTeacher NOTIFY originalTeacherChanged)
    Q_PROPERTY(QString originalSubject READ originalSubject NOTIFY originalSubjectChanged)
    Q_PROPERTY(QString substitutionSubject READ substitutionSubject NOTIFY substitutionSubjectChanged)
    Q_PROPERTY(QString substitutionTeacher READ substitutionTeacher NOTIFY substitutionTeacherChanged)
    Q_PROPERTY(QString substitutionRoom READ substitutionRoom NOTIFY substitutionRoomChanged)
    Q_PROPERTY(QString note READ note NOTIFY noteChanged)
public:
    explicit VPEntry(QObject *parent = nullptr);

    void loadJson(const QJsonObject& object);

    QString form() const { return _form; }
    unsigned int lesson() const { return _lesson; }
    QString originalTeacher() const { return _originalTeacher; }
    QString originalSubject() const { return _originalSubject; }
    QString substitutionTeacher() const { return _substitutionTeacher; }
    QString substitutionSubject() const { return _substitutionSubject; }
    QString substitutionRoom() const { return _substitutionRoom; }
    QString note() const { return _note; }

signals:
    void formChanged(const QString& form);
    void lessonChanged(const unsigned int form);
    void originalTeacherChanged(const QString& originalTeacher);
    void originalSubjectChanged(const QString& originalSubject);
    void substitutionTeacherChanged(const QString& substitutionTeacher);
    void substitutionSubjectChanged(const QString& substitutionSubject);
    void substitutionRoomChanged(const QString& substitutionRoom);
    void noteChanged(const QString& note);

private:
    QString _form;
    unsigned int _lesson;
    QString _originalTeacher;
    QString _originalSubject;
    QString _substitutionTeacher;
    QString _substitutionSubject;
    QString _substitutionRoom;
    QString _note;
};

#endif // VPENTRY_H
