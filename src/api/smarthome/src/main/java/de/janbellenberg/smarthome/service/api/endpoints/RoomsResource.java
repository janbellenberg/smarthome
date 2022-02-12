package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.dao.BuildingsDAO;
import de.janbellenberg.smarthome.dao.RoomsDAO;
import de.janbellenberg.smarthome.model.Building;
import de.janbellenberg.smarthome.model.Room;

@Singleton
@Path("/buildings/{bid}/rooms")
public class RoomsResource {

  @Inject
  RoomsDAO dao;

  @Inject
  BuildingsDAO buildingsDAO;

  @GET
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getRooms(@PathParam("bid") final int bID) {
    return Response.ok().entity(this.dao.getAllRoomsOfUser(bID)).build();
  }

  @POST
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response addRoom(@PathParam("bid") final int bID, final Room room) {
    Building building = this.buildingsDAO.getBuildingById(bID);
    room.setBuilding(building);

    Room inserted = this.dao.saveRoom(room);
    return Response.created(null).entity(inserted).build();
  }

  @PUT
  @Secured
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response updateRoom(@PathParam("id") final int id, final Room room) {
    room.setId(id);
    Room updated = this.dao.saveRoom(room);

    return Response.ok().entity(updated).build();
  }

  @DELETE
  @Secured
  @Path("{id}")
  public Response deleteRoom(@PathParam("id") final int id) {
    this.dao.deleteRoom(id);

    return Response.noContent().build();
  }
}
