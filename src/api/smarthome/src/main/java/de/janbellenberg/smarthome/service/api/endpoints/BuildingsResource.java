package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.dao.BuildingsDAO;
import de.janbellenberg.smarthome.dao.MembersDAO;
import de.janbellenberg.smarthome.model.Building;

@Singleton
@Path("/buildings")
public class BuildingsResource {

  @Inject
  private BuildingsDAO dao;

  @Inject
  private MembersDAO membersDAO;

  @GET
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getBuildings() {
    return Response.ok().entity(this.dao.getAllBuildingsOfUser()).build();
  }

  @POST
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response addBuilding(final Building building, @HeaderParam("X-UID") final int uid) {
    Building inserted = this.dao.saveBuilding(building);
    this.membersDAO.createMembership(uid, inserted.getId());
    return Response.created(null).entity(inserted).build();
  }

  @PUT
  @Secured
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response updateBuilding(@PathParam("id") final int id, final Building building) {
    building.setId(id);
    Building updated = this.dao.saveBuilding(building);
    return Response.ok().entity(updated).build();
  }

  @DELETE
  @Secured
  @Path("{id}")
  public Response deleteBuilding(@PathParam("id") final int id) {
    this.dao.deleteBuilding(id);
    return Response.status(Status.NO_CONTENT).build();
  }
}
