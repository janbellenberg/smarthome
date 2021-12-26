package de.janbellenberg.smarthome.core;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class Configuration {

  private Configuration() {
  }

  private static Configuration currentConfiguration;

  public static Configuration getCurrentConfiguration() {
    if (currentConfiguration == null) {
      currentConfiguration = new Configuration();
    }

    return currentConfiguration;
  }

  /**
   * check if application is running in a docker container
   * 
   * @return is in docker environment
   */
  public boolean isInDocker() {
    try (Stream<String> stream = Files.lines(Paths.get("/proc/1/cgroup"))) {
      return stream.anyMatch(line -> line.contains("/docker"));
    } catch (IOException e) {
      return false;
    }
  }

  /**
   * gets the hostname of the server
   * 
   * @return hostname
   */
  public String getHostname() {

    // get hostname of host os in docker
    String hostInDocker = System.getenv("HOST");
    try {
      if (this.isInDocker() && hostInDocker != null) {
        // if in docker return hostname of host os
        return hostInDocker;
      }

      // else, return own hostname
      return InetAddress.getLocalHost().getHostName();
    } catch (UnknownHostException e) {
      return "localhost";
    }
  }
}
