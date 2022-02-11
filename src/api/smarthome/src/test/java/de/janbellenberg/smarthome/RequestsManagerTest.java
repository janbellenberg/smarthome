package de.janbellenberg.smarthome;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import de.janbellenberg.smarthome.core.DeviceRequestsManager;

public class RequestsManagerTest {

  @Test
  public void testRequestsManager() {
    DeviceRequestsManager m = DeviceRequestsManager.getInstance();
    Assertions.assertNotNull(m);

    Assertions.assertNull(m.getResponse(5, ""));

    m.addRequest(1, "test");
    Assertions.assertNull(m.getResponse(1, "test"));

    m.finishRequest(1, "test", "data");
    Assertions.assertEquals("data", m.getResponse(1, "test"));

    m.removeRequest(1, "test");
    Assertions.assertNull(m.getResponse(1, "test"));

  }

}
