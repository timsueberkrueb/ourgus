TEMPLATE = app

QT += qml quick quickcontrols2 webview

CONFIG += c++11

SOURCES += src/main.cpp \
    src/core/vpapi.cpp \
    src/core/vpcache.cpp \
    src/core/vpdate.cpp \
    src/core/vpentriesmodel.cpp \
    src/core/vpentry.cpp \
    src/core/vpresponse.cpp \

HEADERS += \
    src/core/vpapi.h \
    src/core/vpcache.h \
    src/core/vpdate.h \
    src/core/vpentriesmodel.h \
    src/core/vpentry.h \
    src/core/vpresponse.h \

RESOURCES += src/ui/ui.qrc

DEFINES += QT_DEPRECATED_WARNINGS

DISTFILES += \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /usr/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
unix:!android: {
    desktop.path = /usr/share/applications
    desktop.files += res/OurGUS.desktop
    INSTALLS += desktop
}

OTHER_FILES += \
    README.md \
    LICENSE.*

# api server configuration
include(vp-api-config.pri)
