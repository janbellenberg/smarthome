package de.janbellenberg.smarthome.service.ws;

import java.io.IOException;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/device/socket", configurator = SocketConfigurator.class)
public class DeviceSocket {

  @OnOpen
  public void open(Session session, EndpointConfig config) throws IOException {
    // TODO: implement device socket
  }

  @OnClose
  public void close(Session session, CloseReason reason) {
    // TODO: implement device socket
  }

  @OnMessage
  public void onMessage(Session session, String msg) {
    // TODO: implement device socket
  }
}
