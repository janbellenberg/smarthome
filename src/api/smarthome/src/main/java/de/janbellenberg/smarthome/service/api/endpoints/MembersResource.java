package de.janbellenberg.smarthome.service.api.endpoints;

import java.time.LocalDateTime;
import java.time.ZoneId;
import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.base.helper.security.JWT;
import de.janbellenberg.smarthome.dao.MembersDAO;

@Singleton
@Path("/buildings/join")
public class MembersResource {

  @Inject
  MembersDAO dao;

  @POST
  @Secured
  @Consumes(MediaType.TEXT_PLAIN)
  public Response addMember(@HeaderParam("X-UID") final int uid, String jwtRaw) {
    JWT jwt = JWT.parse(jwtRaw);

    if (jwt == null) {
      return Response.status(410).build();
    }

    LocalDateTime now = LocalDateTime.now().minusHours(1);
    long beforeOneHour = now.toEpochSecond(ZoneId.systemDefault().getRules().getOffset(now));

    if (beforeOneHour > jwt.getPayload().getInt("iat")) {
      return Response.status(410).build();
    }

    this.dao.createMembership(uid, jwt.getPayload().getInt("sub"));
    return Response.created(null).build();
  }

  @GET
  @Path("/{bid}")
  @Secured
  public Response generateJoinToken(@PathParam("bid") final int buildingID) {
    return Response.ok(JWT.generate(buildingID).toString()).build();
  }

  /*
   * @DELETE
   * 
   * @Secured public Response deleteMember(@PathParam("bid") final int
   * buildingID, @HeaderParam("X-UID") final int uid) {
   * this.dao.removeMembership(uid, buildingID); return
   * Response.noContent().build(); }
   */
}
