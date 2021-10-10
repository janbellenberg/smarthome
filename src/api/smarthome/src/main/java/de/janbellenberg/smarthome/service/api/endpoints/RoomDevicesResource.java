package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
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
import de.janbellenberg.smarthome.dao.DevicesDAO;
import de.janbellenberg.smarthome.dao.RoomsDAO;
import de.janbellenberg.smarthome.model.Device;
import de.janbellenberg.smarthome.model.Room;

@Singleton
@Path("/rooms/{rid}/devices")
public class RoomDevicesResource {

  @Inject
  DevicesDAO dao;

  @Inject
  RoomsDAO roomsDAO;

  @GET
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getDevicesOfRoom(@PathParam("rid") final int roomID) {
    // TODO: check if user is member
    return Response.ok().entity(this.dao.getAllDevicesInRoom(roomID)).build();
  }

  @POST
  @Secured
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response addDeviceToRoom(@PathParam("rid") final int roomID, @PathParam("id") final int deviceID) {

    Room room = this.roomsDAO.getRoomById(roomID);
    Device device = this.dao.getDeviceByID(deviceID);
    device.setRoom(room);
    this.dao.saveDevice(device);

    return Response.created(null).build();
  }

  @DELETE
  @Secured
  @Path("{id}")
  public Response removeDeviceFromRoom(@PathParam("rid") final int roomID, @PathParam("id") final int deviceID) {
    Device device = this.dao.getDeviceByID(deviceID);

    if (device.getRoom() == null || device.getRoom().getId() != roomID) {
      return Response.notAcceptable(null).build();
    }

    device.setRoom(null);
    this.dao.saveDevice(device);
    return Response.noContent().build();
  }
}
