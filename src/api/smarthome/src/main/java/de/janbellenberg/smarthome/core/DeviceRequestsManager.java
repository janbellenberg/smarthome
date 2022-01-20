package de.janbellenberg.smarthome.core;

import java.util.HashMap;

public class DeviceRequestsManager {
  private static DeviceRequestsManager instance;
  private HashMap<String, String> requests;

  private DeviceRequestsManager() {
    this.requests = new HashMap<>();
  }

  public static DeviceRequestsManager getInstance() {
    if (instance == null) {
      instance = new DeviceRequestsManager();
    }

    return instance;
  }

  public void addRequest(String command) {
    this.requests.put(command, null);

    // TODO: start timer for timeout
  }

  public void finishRequest(String command, String data) {
    this.requests.computeIfAbsent(command, c -> data);
  }

  public String getResponse(String command) {
    return this.requests.get(command);
  }
}
