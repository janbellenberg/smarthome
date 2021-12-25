package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.dao.BuildingsDAO;
import de.janbellenberg.smarthome.dao.MembersDAO;
import de.janbellenberg.smarthome.dao.ShortcutsDAO;
import de.janbellenberg.smarthome.model.Member;

@Singleton
@Path("/buildings/{bid}/shortcuts")
public class ShortcutsResource {

  @Inject
  private ShortcutsDAO dao;

  @Inject
  BuildingsDAO buildingsDAO;

  @Inject
  MembersDAO membersDAO;

  @GET
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getShortcuts(@HeaderParam("X-UID") final int uid, @PathParam("bid") final int bID) {
    Member member = this.membersDAO.getMember(uid, bID);

    if (member == null) {
      return Response.status(Status.UNAUTHORIZED).build();
    }

    return Response.ok().entity(this.dao.getAllShortcutsOfBuilding(bID)).build();
  }
}
