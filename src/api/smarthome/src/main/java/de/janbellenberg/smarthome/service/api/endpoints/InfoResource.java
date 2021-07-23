package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * 
 * 
 * @author janbellenberg
 *
 */
@Singleton
@Path("/")
public class InfoResource {

  /**
   * send that the server is running
   * 
   * @return HTTP Response (always 200 OK)
   */
  @GET
  @Path("/health")
  public Response answerHealthRequest() {
    return Response.ok().build();
  }

  @GET
  @Path("/info")
  @Produces(MediaType.APPLICATION_JSON)
  public Response answerInfo() {
    JsonObjectBuilder result = Json.createObjectBuilder();
    JsonObjectBuilder version = Json.createObjectBuilder();

    version.add("api", 1.0);
    version.add("app", 1.0);
    version.add("protocol", 1.0);

    result.add("current_version", version.build());

    return Response.ok(result.build()).build();
  }
}
