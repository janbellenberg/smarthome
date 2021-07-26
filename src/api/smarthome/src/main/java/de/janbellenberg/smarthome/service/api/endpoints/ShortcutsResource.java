package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import de.janbellenberg.smarthome.dao.BuildingsDAO;
import de.janbellenberg.smarthome.dao.ShortcutsDAO;
import de.janbellenberg.smarthome.model.Building;
import de.janbellenberg.smarthome.model.Shortcut;

@Singleton
@Path("/buildings/{bid}/shortcuts")
public class ShortcutsResource {

  @Inject
  private ShortcutsDAO dao;

  @Inject
  BuildingsDAO buildingsDAO;

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response getShortcuts(@PathParam("bid") final int bID) {
    return Response.ok().entity(this.dao.getAllShortcutsOfUser(bID)).build();
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response addShortcut(@PathParam("bid") final int bID, Shortcut shortcut) {
    Building building = this.buildingsDAO.getBuildingById(bID);
    shortcut.setBuilding(building);

    Shortcut inserted = this.dao.saveShortcut(shortcut);
    return Response.ok().entity(inserted).build();
  }

  @DELETE
  @Path("{id}")
  public Response deleteShortcut(@PathParam("id") final int id) {
    this.dao.deleteShortcut(id);

    return Response.ok().build();
  }
}
