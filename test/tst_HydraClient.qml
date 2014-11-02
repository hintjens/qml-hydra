
import QtTest 1.0
import QtQuick 2.1

import org.edgenet.hydra 1.0


TestCase {
  id: test
  name: "HydraClient"
  
  HydraClient {
    id:subject
  }
  
  function test_selfTest() {
    var verbose = false
    HydraClient.selfTest(verbose)
  }
}
