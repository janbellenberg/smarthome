package de.janbellenberg.smarthome.core;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Stream;

import com.fasterxml.jackson.databind.JsonNode;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

import org.bson.Document;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import de.janbellenberg.smarthome.base.MongoConnectionManager;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

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

  public JsonNode getMailConfig() {
    try {
      // get mongo db data
      MongoCollection<Document> settings = MongoConnectionManager.getInstance().getSettingsCollection();
      FindIterable<Document> docs = settings.find();
      MongoCursor<Document> iterator = docs.iterator();

      if (!iterator.hasNext()) {
        return null;
      }

      // parse mongo db json
      JsonParser json = new JsonFactory().createParser(iterator.next().toJson());
      return new ObjectMapper().readValue(json, ObjectNode.class).get("mail");
    } catch (IOException e) {
      e.printStackTrace();
      return null;
    }
  }

  public JsonNode getVersionConfig() {
    try {
      // get mongo db data
      MongoCollection<Document> settings = MongoConnectionManager.getInstance().getSettingsCollection();
      FindIterable<Document> docs = settings.find();
      MongoCursor<Document> iterator = docs.iterator();

      if (!iterator.hasNext()) {
        return null;
      }

      // parse mongo db json
      JsonParser json = new JsonFactory().createParser(iterator.next().toJson());
      return new ObjectMapper().readValue(json, ObjectNode.class).get("versions");
    } catch (IOException e) {
      e.printStackTrace();
      return null;
    }
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
