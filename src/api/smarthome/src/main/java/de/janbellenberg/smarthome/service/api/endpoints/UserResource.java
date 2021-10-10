package de.janbellenberg.smarthome.service.api.endpoints;

import java.util.List;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.PATCH;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.base.helper.security.PasswordHelper;
import de.janbellenberg.smarthome.dao.UsersDAO;
import de.janbellenberg.smarthome.model.User;

@Singleton
@Path("/user")
public class UserResource {

  @Inject
  UsersDAO dao;

  @GET
  @Secured
  @Produces(MediaType.APPLICATION_JSON)
  public Response getUserInformation(@HeaderParam("X-UID") final int uid) {
    return Response.ok(this.dao.getUserById(uid)).build();
  }

  @Path("/local")
  @POST
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response createUser(User user) {
    List<String> existing = this.dao.getSalts();
    String salt = PasswordHelper.generateSalt(existing);
    String pepper = PasswordHelper.generatePepper();

    user.getLocalUser().setPassword(PasswordHelper.generateHash(user.getLocalUser().getPassword(), salt, pepper));
    user.getLocalUser().setSalt(salt);

    User inserted = this.dao.saveUser(user);
    return Response.created(null).entity(inserted).build();
  }

  @PATCH
  @Secured
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response updateUserInformation(User user, @HeaderParam("X-UID") final int uid) {
    user.setId(uid);
    User updated = this.dao.saveUser(user);
    return Response.ok().entity(updated).build();
  }

  @DELETE
  public Response deleteUser(@HeaderParam("X-UID") final int uid) {
    // TODO: delete sessions
    this.dao.deleteUser(uid);
    return Response.noContent().build();
  }
}
