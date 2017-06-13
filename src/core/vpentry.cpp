#include "vpentry.h"

VPEntry::VPEntry(QObject *parent)
    : QObject(parent)
{

}

void VPEntry::loadJson(const QJsonObject &object)
{
    emit formChanged(_form = object["form"].toString());
    emit lessonChanged(_lesson = object["lesson"].toInt());
    emit originalTeacherChanged(_originalTeacher = object["originalTeacher"].toString());
    emit originalSubjectChanged(_originalSubject = object["originalSubject"].toString());
    emit substitutionTeacherChanged(_substitutionTeacher = object["substitutionTeacher"].toString());
    emit substitutionSubjectChanged(_substitutionSubject = object["substitutionSubject"].toString());
    emit substitutionRoomChanged(_substitutionRoom = object["substitutionRoom"].toString());
    emit noteChanged(_note = object["note"].toString());
}
