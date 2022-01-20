package de.janbellenberg.smarthome.service.api.endpoints;

import java.io.IOException;

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
    manager.addRequest(command);

    session.getBasicRemote().sendText(command);

    String response;
    // TODO: implement timeout
    while ((response = manager.getResponse(command)) == null)
      ;

    return Response.ok(response).build();
  }
}
