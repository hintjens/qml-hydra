
TEMPLATE = lib

CONFIG += plugin
QT += qml quick

TARGET = $$qtLibraryTarget(hydraplugin)
uri = org.edgenet.hydra

DESTDIR   = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
SRCDIR    = $$PWD/src
BUILDDIR  = $$PWD/build/native

android {
  VENDORDIR = $$PWD/vendor/prefix/$(TOOLCHAIN_NAME)
  BUILDDIR  = $$PWD/build/$(TOOLCHAIN_NAME)
  QMAKE_LIBDIR += $$VENDORDIR/lib
  QMAKE_INCDIR += $$VENDORDIR/include
}

LIBS += -lhydra

HEADERS += $$SRCDIR/hydraplugin.h  \
           $$SRCDIR/qml_hydra_server.h \
           $$SRCDIR/qml_hydra_client.h

OBJECTS_DIR = $$BUILDDIR/.obj
MOC_DIR     = $$BUILDDIR/.moc
RCC_DIR     = $$BUILDDIR/.rcc
UI_DIR      = $$BUILDDIR/.ui

target.path  = $$DESTDIR
qmldir.files = $$PWD/qmldir
qmldir.path  = $$DESTDIR

OTHER_FILES += $$SRCDIR/qmldir \
               $$SRCDIR/qml/*

INSTALLS    += target qmldir

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += \
  $$QMAKE_COPY $$replace($$list($$quote($$SRCDIR/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)

# Copy the libzmq shared library to the plugin folder (on android only)
android {
  QMAKE_POST_LINK += \
 && $$QMAKE_COPY $$replace($$list($$quote($$VENDORDIR/lib/libsodium.so) $$DESTDIR), /, $$QMAKE_DIR_SEP) \
 && $$QMAKE_COPY $$replace($$list($$quote($$VENDORDIR/lib/libzmq.so)    $$DESTDIR), /, $$QMAKE_DIR_SEP) \
 && $$QMAKE_COPY $$replace($$list($$quote($$VENDORDIR/lib/libczmq.so)   $$DESTDIR), /, $$QMAKE_DIR_SEP) \
 && $$QMAKE_COPY $$replace($$list($$quote($$VENDORDIR/lib/libzyre.so)   $$DESTDIR), /, $$QMAKE_DIR_SEP) \
 && $$QMAKE_COPY $$replace($$list($$quote($$VENDORDIR/lib/libhydra.so)  $$DESTDIR), /, $$QMAKE_DIR_SEP)
}
