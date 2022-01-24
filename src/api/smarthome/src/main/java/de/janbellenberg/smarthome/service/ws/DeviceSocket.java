package de.janbellenberg.smarthome.service.ws;

import java.io.IOException;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.mongodb.client.MongoCollection;

import org.bson.Document;
import org.bson.types.ObjectId;

import de.janbellenberg.smarthome.base.MongoConnectionManager;
import de.janbellenberg.smarthome.base.helper.security.JWT;
import de.janbellenberg.smarthome.core.DeviceRequestsManager;
import de.janbellenberg.smarthome.core.SocketConnectionManager;
import static com.mongodb.client.model.Filters.*;

@ServerEndpoint(value = "/device/socket")
public class DeviceSocket {

  @OnOpen
  public void open(Session session, EndpointConfig config) throws IOException {
    String token = this.getToken(session);
    JWT jwt = JWT.parse(token);

    // jwt is invalid
    if (jwt == null) {
      session.close();
      return;
    }

    int deviceID = jwt.getPayload().getInt("sub");
    SocketConnectionManager.getInstance().startConnection(deviceID, session);
  }

  @OnClose
  public void close(Session session, CloseReason reason) {

    String token = this.getToken(session);
    JWT jwt = JWT.parse(token);

    // jwt cant be parsed (should never appear)
    if (jwt == null) {
      return;
    }

    int deviceID = jwt.getPayload().getInt("sub");
    SocketConnectionManager.getInstance().stopConnection(deviceID);
  }

  @OnMessage
  public void onMessage(Session session, String msg) {

    String token = this.getToken(session);
    JWT jwt = JWT.parse(token);

    // jwt cant be parsed (should never appear)
    if (jwt == null) {
      return;
    }

    int deviceID = jwt.getPayload().getInt("sub");

    if (msg.startsWith("#")) {
      String command = msg.split("\n")[0].replaceFirst("#", "");
      String data = msg.replaceFirst("#" + command + "\n", "");
      DeviceRequestsManager.getInstance().finishRequest(deviceID, command, data);
    } else {
      MongoCollection<Document> deviceInfos = MongoConnectionManager.getInstance().getDeviceInfosCollection();

      deviceInfos.deleteMany(eq("id", deviceID));

      Document deviceInfo = Document.parse(msg);
      deviceInfo.put("_id", new ObjectId());
      deviceInfo.put("id", deviceID);

      deviceInfos.insertOne(deviceInfo);
    }
  }

  private String getToken(Session session) {
    try {
      return session.getRequestParameterMap().get("token").get(0);
    } catch (Exception ignore) {
      return "";
    }
  }
}
