package de.janbellenberg.smarthome.base;

import com.mongodb.*;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;

import org.bson.Document;

import de.janbellenberg.smarthome.core.Configuration;

import java.util.ArrayList;
import java.util.List;

public class MongoConnectionManager {

  private MongoConnectionManager() {
  }

  private static final String MONGO_HOST = Configuration.getCurrentConfiguration().isInDocker() ? "mongo" : "localhost";
  private static final int MONGO_PORT = 27017;
  private static final String MONGO_USER = "smarthome";
  private static final char[] MONGO_PSWD = "gXg33Ep4urGp6bF2".toCharArray();
  private static final String MONGO_DB = MONGO_USER;
  private static final String COLL_SESSION = "sessions";
  private static final String COLL_SETTINGS = "settings";
  private static final String COLL_DEVICES = "devices_infos";
  private static MongoConnectionManager instance;

  private MongoClient client;

  public static MongoConnectionManager getInstance() {
    if (instance == null) {
      instance = new MongoConnectionManager();
      instance.initConnection();
    }

    return instance;
  }

  private boolean initConnection() {
    List<ServerAddress> mongoHostList = new ArrayList<>();
    mongoHostList.add(new ServerAddress(MONGO_HOST, MONGO_PORT));

    try {
      MongoClientSettings mongoClientSettings = MongoClientSettings.builder()
          .credential(MongoCredential.createCredential(MONGO_USER, MONGO_DB, MONGO_PSWD))
          .applyToClusterSettings(clusterSettingsBuilder -> clusterSettingsBuilder.hosts(mongoHostList))
          .writeConcern(WriteConcern.W1).readConcern(ReadConcern.MAJORITY).readPreference(ReadPreference.nearest())
          .retryWrites(true).build();

      this.client = MongoClients.create(mongoClientSettings);

      return true;

    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }

  public MongoCollection<Document> getSettingsCollection() {
    return this.client.getDatabase(MONGO_DB).getCollection(COLL_SETTINGS);
  }

  public MongoCollection<Document> getSessionCollection() {
    return this.client.getDatabase(MONGO_DB).getCollection(COLL_SESSION);
  }

  public MongoCollection<Document> getDeviceInfosCollection() {
    return this.client.getDatabase(MONGO_DB).getCollection(COLL_DEVICES);
  }

}
