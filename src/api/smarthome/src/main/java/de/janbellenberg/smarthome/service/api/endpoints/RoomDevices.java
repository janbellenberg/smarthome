package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Singleton
@Path("/buildings/{id}/rooms/{id}/devices")
public class RoomDevices {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getDevicesOfRoom() {
    // TODO: implement
    return Response.ok().build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public Response addDeviceToRoom() {
    // TODO: implement
    return Response.ok().build();
  }

  @DELETE
  public Response removeDeviceFromRoom() {
    // TODO: implement
    return Response.ok().build();
  }
}
