QT += qml quick quickcontrols2 svg

TARGET = ourgus

android: {
    QT += webview
    DEFINES += USE_QTWEBVIEW
} else {
    QT += webengine
    DEFINES += USE_QTWEBENGINE
}

CONFIG += c++11

SOURCES += main.cpp \
    core/vpapi.cpp \
    core/vpcache.cpp \
    core/vpdate.cpp \
    core/vpentriesmodel.cpp \
    core/vpentry.cpp \
    core/vpresponse.cpp \

HEADERS += \
    core/vpapi.h \
    core/vpcache.h \
    core/vpdate.h \
    core/vpentriesmodel.h \
    core/vpentry.h \
    core/vpresponse.h \

RESOURCES += ui/ui.qrc \
             ../res/res.qrc \

DEFINES += QT_DEPRECATED_WARNINGS

DISTFILES += \
    ../android/AndroidManifest.xml \
    ../android/res/values/libs.xml \
    ../android/build.gradle

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /usr/bin
!isEmpty(target.path): INSTALLS += target

unix:!android: {
    iconSVG.files = ../res/ourgus.svg
    iconSVG.path = /usr/local/share/icons/hicolor/scalable/apps
    INSTALLS += iconSVG

    desktop.path = /usr/share/applications
    desktop.files += ../res/OurGUS.desktop
    INSTALLS += desktop
}

android {
    # Bundle Fluid QML plugins with the application
    ANDROID_EXTRA_PLUGINS = $$OUT_PWD/../fluid/qml

    # Android package sources
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../android
}

macx {
    # Bundle Fluid QML plugins with the application
    APP_QML_FILES.files = $$OUT_PWD/../fluid/qml/Fluid
    APP_QML_FILES.path = Contents/MacOS
    QMAKE_BUNDLE_DATA += APP_QML_FILES
}

win32 {
    WINDEPLOYQT_OPTIONS = -qmldir $$OUT_PWD/../fluid/qml/Fluid
}

# api server configuration
exists(vp-api-config.pri) {
    include(vp-api-config.pri)
}
