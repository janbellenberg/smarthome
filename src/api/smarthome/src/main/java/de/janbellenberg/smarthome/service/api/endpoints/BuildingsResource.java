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
@Path("/buildings")
public class BuildingsResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getBuildings() {
    // TODO: implement getBuildings
    return Response.ok().build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public Response addBuilding(JsonObject request) {
    // TODO: implement addBuilding
    return Response.ok().build();
  }

  @PUT
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response updateBuilding(JsonObject request) {
    // TODO: implement updateBuilding
    return Response.ok().build();
  }

  @DELETE
  @Path("{id}")
  public Response deleteBuilding() {
    // TODO: implement deleteBuilding
    return Response.ok().build();
  }
}
