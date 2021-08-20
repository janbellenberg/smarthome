package de.janbellenberg.smarthome.service.api.endpoints;

import java.util.List;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.dao.MembersDAO;
import de.janbellenberg.smarthome.model.Member;

@Singleton
@Path("/buildings/{bid}/members")
public class MembersResource {

  @Inject
  MembersDAO dao;

  @GET
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getMembers(@PathParam("bid") final int buildingID, @HeaderParam("X-UID") final int uid) {
    List<Member> members = this.dao.getMembersOfBuilding(buildingID);

    JsonArrayBuilder resultBuilder = Json.createArrayBuilder();
    boolean isMember = false;
    for (Member m : members) {
      resultBuilder.add(m.getUser().getId());

      // check if client-user is a member of the building
      if (uid == m.getUser().getId()) {
        isMember = true;
      }
    }

    // send 401 Unauthorized when client-user is not a member
    if (isMember) {
      return Response.ok().entity(resultBuilder.build()).build();
    } else {
      throw new NotAuthorizedException(Response.status(Status.UNAUTHORIZED).build());
    }
  }

  @POST
  @Secured
  public Response addMember(@PathParam("bid") final int buildingID, @HeaderParam("X-UID") final int uid) {
    this.dao.createMembership(uid, buildingID);

    return Response.ok().build();
  }

  @DELETE
  @Secured
  public Response deleteMember(@PathParam("bid") final int buildingID, @HeaderParam("X-UID") final int uid) {
    this.dao.removeMembership(uid, buildingID);
    return Response.ok().build();
  }
}
