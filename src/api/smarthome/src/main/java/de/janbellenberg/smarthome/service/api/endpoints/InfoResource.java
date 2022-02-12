package de.janbellenberg.smarthome.service.api.endpoints;

import java.io.IOException;
import javax.ejb.Singleton;
import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import com.fasterxml.jackson.databind.JsonNode;

import de.janbellenberg.smarthome.core.Configuration;

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
  public Response answerInfo() throws IOException {
    JsonObjectBuilder result = Json.createObjectBuilder();
    JsonObjectBuilder version = Json.createObjectBuilder();

    JsonNode node = Configuration.getCurrentConfiguration().getVersionConfig();

    // format result
    version.add("api", node.get("api").asDouble());
    version.add("app", node.get("app").asDouble());
    version.add("protocol", node.get("protocol").asDouble());

    result.add("current_version", version.build());

    return Response.ok(result.build()).build();
  }
}
