package de.janbellenberg.smarthome.service.ws;

import java.io.IOException;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import de.janbellenberg.smarthome.core.DeviceRequestsManager;
import de.janbellenberg.smarthome.core.SocketConnectionManager;

@ServerEndpoint(value = "/device/socket")
public class DeviceSocket {

  @OnOpen
  public void open(Session session, EndpointConfig config) throws IOException {
    // TODO: implement check jwt

    int deviceID = 1;
    SocketConnectionManager.getInstance().startConnection(deviceID, session);
  }

  @OnClose
  public void close(Session session, CloseReason reason) {
    // TODO: get devID from token
    int deviceID = 1;
    SocketConnectionManager.getInstance().stopConnection(deviceID);
  }

  @OnMessage
  public void onMessage(Session session, String msg) {
    if (msg.startsWith("#")) {
      String command = msg.split("\n")[0].replaceFirst("#", "");
      String data = msg.replaceFirst("#" + command + "\n", "");
      DeviceRequestsManager.getInstance().finishRequest(command, data);
    } else {
      // TODO: save info to mongo
    }
  }

  private String getToken(Session session) {
    return session.getRequestParameterMap().get("token").get(0);
  }
}
