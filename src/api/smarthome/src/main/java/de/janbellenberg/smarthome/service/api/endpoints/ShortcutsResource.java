package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Singleton
@Path("/buildings/{id}/shortcuts")
public class ShortcutsResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getShortcuts() {
    // TODO: implement getShortcuts
    return Response.ok().build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public Response addShortcut(JsonObject request) {
    // TODO: implement addShortcut
    return Response.ok().build();
  }

  @DELETE
  @Path("{id}")
  public Response deleteShortcut() {
    // TODO: implement deleteShortcut
    return Response.ok().build();
  }
}
