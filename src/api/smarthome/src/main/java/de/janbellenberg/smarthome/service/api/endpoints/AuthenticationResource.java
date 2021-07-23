package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.Produces;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Singleton
@Path("/auth")
public class AuthenticationResource {

  @POST
  @Path("/login")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response performLogin(JsonObject request) {
    // TODO: implement performLogin
    return Response.ok().build();
  }

  @DELETE
  @Path("/logout")
  public Response performLogout() {

    // TODO: implement performLogout
    return Response.ok().build();
  }
}
