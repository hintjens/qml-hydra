
import QtTest 1.0
import QtQuick 2.1

import org.edgenet.hydra 1.0


TestCase {
  id: test
  name: "HydraServer"
  
  HydraServer {
    id:subject
  }
  
  function test_selfTest() {
    var verbose = false
    HydraServer.selfTest(verbose)
  }
}
