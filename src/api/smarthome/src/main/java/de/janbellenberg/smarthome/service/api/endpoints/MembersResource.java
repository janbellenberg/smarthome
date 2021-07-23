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
@Path("/buildings/{id}/members")
public class MembersResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getMembers() {
    // TODO: implement getMembers
    return Response.ok().build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public Response addMember(JsonObject request) {
    // TODO: implement addMember
    return Response.ok().build();
  }

  @DELETE
  @Path("{id}")
  public Response deleteMember() {
    // TODO: implement deleteMember
    return Response.ok().build();
  }
}
