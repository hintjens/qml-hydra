
#ifndef QML_HYDRA_SERVER_H
#define QML_HYDRA_SERVER_H

#include <QtQml>

#include <hydra.h>


class HydraServer;

class HydraServerAttached : public QObject
{
    Q_OBJECT
    
    QObject* m_attached;
    
public:
    
    HydraServerAttached(QObject* attached) { m_attached = attached; };
    
public slots:
    
    void selfTest(bool verbose) {
        return hydra_server_test(verbose);
    };
};


class HydraServer : public QObject
{
    Q_OBJECT
    
private:
    
    hydra_server_t* self;
    
public:
    
    HydraServer() {
        self = NULL;
    };
    
    ~HydraServer() {
    };
    
    static QObject* qmlAttachedProperties(QObject* object) {
        return new HydraServerAttached(object);
    }
};


QML_DECLARE_TYPEINFO(HydraServer, QML_HAS_ATTACHED_PROPERTIES)

#endif
