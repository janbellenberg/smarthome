package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PATCH;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Singleton
@Path("/user")
public class UserResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getUserInformation() {
    // TODO: implement getUserInformation
    return Response.ok().build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public Response createUser() {
    // TODO: implement createUser
    return Response.ok().build();
  }

  @PATCH
  @Consumes(MediaType.APPLICATION_JSON)
  public Response updateUserInformation() {
    // TODO: implement updateUserInformation
    return Response.ok().build();
  }

  @DELETE
  public Response deleteUser() {
    // TODO: implement deleteUser
    return Response.ok().build();
  }
}
