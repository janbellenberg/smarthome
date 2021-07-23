package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Singleton
@Path("/buildings/{id}/rooms")
public class RoomsResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getRooms() {
    // TODO: implement getRooms
    return Response.ok().build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public Response addRoom(JsonObject request) {
    // TODO: implement addRoom
    return Response.ok().build();
  }

  @PUT
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response updateRoom(JsonObject request) {
    // TODO: implement updateRoom
    return Response.ok().build();
  }

  @DELETE
  @Path("{id}")
  public Response deleteRoom() {
    // TODO: implement deleteRoom
    return Response.ok().build();
  }
}
