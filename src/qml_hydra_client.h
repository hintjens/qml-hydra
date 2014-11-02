
#ifndef QML_HYDRA_CLIENT_H
#define QML_HYDRA_CLIENT_H

#include <QtQml>

#include <hydra.h>


class HydraClient;

class HydraClientAttached : public QObject
{
    Q_OBJECT
    
    QObject* m_attached;
    
public:
    
    HydraClientAttached(QObject* attached) { m_attached = attached; };
    
public slots:
    
    void selfTest(bool verbose) {
        return hydra_client_test(verbose);
    };
};


class HydraClient : public QObject
{
    Q_OBJECT
    
private:
    
    hydra_client_t* self;
    
public:
    
    HydraClient() {
        self = NULL;
    };
    
    ~HydraClient() {
    };
    
    static QObject* qmlAttachedProperties(QObject* object) {
        return new HydraClientAttached(object);
    }
};


QML_DECLARE_TYPEINFO(HydraClient, QML_HAS_ATTACHED_PROPERTIES)

#endif
