package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Singleton
@Path("/device")
public class DeviceResource {

  @POST
  @Path("/init")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response initializeDevice(JsonObject request) {
    // TODO: implement initializeDevice
    return Response.ok().build();
  }

  @POST
  @Path("/cmd")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response sendComandToDevice(JsonObject request) {
    // TODO: implement sendComandToDevce
    return Response.ok().build();
  }
}
