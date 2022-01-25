package de.janbellenberg.smarthome.service.api.endpoints;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.websocket.Session;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.*;

import org.bson.Document;

import de.janbellenberg.smarthome.base.MongoConnectionManager;
import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.core.DeviceRequestsManager;
import de.janbellenberg.smarthome.core.SocketConnectionManager;
import de.janbellenberg.smarthome.dao.DevicesDAO;
import de.janbellenberg.smarthome.dao.RoomsDAO;
import de.janbellenberg.smarthome.model.Device;
import de.janbellenberg.smarthome.model.Room;

@Singleton
@Path("/devices")
public class DeviceResource {

  @Inject
  DevicesDAO dao;

  @Inject
  RoomsDAO roomsDAO;

  @GET
  @Path("room/{rid}")
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getAllDevicesInRoom(@PathParam("rid") final int roomID) {
    return Response.ok(this.dao.getAllDevicesInRoom(roomID)).build();
  }

  @GET
  @Path("/{id}")
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getDeviceConfig(@PathParam("id") final int deviceID) {
    MongoCollection<Document> deviceInfos = MongoConnectionManager.getInstance().getDeviceInfosCollection();
    Document info = deviceInfos.find(eq("id", deviceID)).first();

    if (info == null) {
      return Response.noContent().build();
    }

    info.remove("_id");
    info.remove("id");
    return Response.ok(info.toJson()).build();
  }

  @POST
  @Path("/configure")
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response configureDevice(Device device) {
    Device inserted = this.dao.saveDevice(device);
    return Response.created(null).entity(inserted).build();
  }

  @POST
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response initializeDevice(JsonObject data) {
    Device device = new Device();
    device.setMac(data.getString("mac"));

    Room room = this.roomsDAO.getRoomById(data.getInt("room"));
    device.setRoom(room);

    device = this.dao.saveDevice(device);
    return Response.created(null).entity(device).build();
  }

  @DELETE
  @Secured
  @Path("{id}")
  public Response deleteDevice(@PathParam("id") final int id) {
    this.dao.deleteDevice(id);
    return Response.noContent().build();
  }

  @POST
  @Secured
  @Path("{id}/cmd")
  @Consumes(MediaType.TEXT_PLAIN)
  @Produces(MediaType.APPLICATION_OCTET_STREAM)
  public Response sendComandToDevice(@PathParam("id") int deviceID, String command) throws IOException {
    command = command.trim();

    Session session = SocketConnectionManager.getInstance().getSessionByDeviceID(deviceID);

    if (session == null) {
      return Response.status(502).build(); // Bad Gateway
    }

    DeviceRequestsManager manager = DeviceRequestsManager.getInstance();
    manager.addRequest(deviceID, command);

    session.getBasicRemote().sendText(command);

    String response;
    LocalDateTime start = LocalDateTime.now();

    while ((response = manager.getResponse(deviceID, command)) == null) {

      // timeout after 3 seconds
      if (Duration.between(start, LocalDateTime.now()).toSeconds() > 5) {
        manager.removeRequest(deviceID, command);
        return Response.status(504).build();
      }
    }

    manager.removeRequest(deviceID, command);
    return Response.ok(response).build();
  }
}
