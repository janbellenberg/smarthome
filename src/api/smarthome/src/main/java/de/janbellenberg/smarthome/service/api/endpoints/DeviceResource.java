package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.dao.DevicesDAO;
import de.janbellenberg.smarthome.model.Device;

@Singleton
@Path("/devices")
public class DeviceResource {

  @Inject
  DevicesDAO dao;

  @POST
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response initializeDevice(Device device) {
    Device inserted = this.dao.saveDevice(device);
    return Response.created(null).entity(inserted).build();
  }

  @DELETE
  @Secured
  @Path("/{id}")
  public Response deleteDevice(@PathParam("id") final int id) {
    this.dao.deleteDevice(id);
    return Response.ok().build();
  }

  @POST
  @Secured
  @Path("/{id}/cmd")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response sendComandToDevice(JsonObject request) {
    // TODO: implement sendComandToDevce
    return Response.ok().build();
  }
}
