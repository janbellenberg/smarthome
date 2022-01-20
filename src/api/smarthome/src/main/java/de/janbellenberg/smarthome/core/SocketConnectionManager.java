package de.janbellenberg.smarthome.core;

import java.util.HashMap;

import javax.websocket.Session;

public class SocketConnectionManager {
  private static SocketConnectionManager instance;

  private HashMap<Integer, Session> connections;
  
  private SocketConnectionManager() {
    this.connections = new HashMap<>();
  }

  public static SocketConnectionManager getInstance() {
    if(instance == null) {
      instance = new SocketConnectionManager();
    }

    return instance;
  }

  public void startConnection(int deviceID, Session session){
    this.connections.put(deviceID, session);
  }

  public void stopConnection(int deviceID) {
    this.connections.remove(deviceID);
  }
  
  public Session getSessionByDeviceID(int deviceID) {
    return this.connections.get(deviceID);
  }
  
}
