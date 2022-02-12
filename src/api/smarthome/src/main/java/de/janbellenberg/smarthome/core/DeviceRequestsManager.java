package de.janbellenberg.smarthome.core;

import java.util.HashMap;

import de.janbellenberg.smarthome.base.helper.Tupel;

public class DeviceRequestsManager {
  private static DeviceRequestsManager instance;
  private HashMap<Tupel<Integer, String>, String> requests;

  private DeviceRequestsManager() {
    this.requests = new HashMap<>();
  }

  public static DeviceRequestsManager getInstance() {
    if (instance == null) {
      instance = new DeviceRequestsManager();
    }

    return instance;
  }

  public void addRequest(int deviceID, String command) {
    Tupel<Integer, String> request = new Tupel<>(deviceID, command);
    this.requests.put(request, null);
  }

  public void finishRequest(int deviceID, String command, String data) {
    Tupel<Integer, String> request = new Tupel<>(deviceID, command);

    this.requests.computeIfAbsent(request, c -> data);
  }

  public void removeRequest(int deviceID, String command) {
    Tupel<Integer, String> request = new Tupel<>(deviceID, command);
    this.requests.remove(request);
  }

  public String getResponse(int deviceID, String command) {
    Tupel<Integer, String> request = new Tupel<>(deviceID, command);
    return this.requests.get(request);
  }
}
