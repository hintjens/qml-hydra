
#include <QQmlExtensionPlugin>

#include <qqml.h>

#include "qml_hydra_server.h"
#include "qml_hydra_client.h"


class HydraPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
    
public:
    void registerTypes(const char *uri)
    {
        qmlRegisterType<HydraServer> (uri, 1, 0, "HydraServer");
        qmlRegisterType<HydraServerAttached>();
        qmlRegisterType<HydraClient> (uri, 1, 0, "HydraClient");
        qmlRegisterType<HydraClientAttached>();
    };
};
