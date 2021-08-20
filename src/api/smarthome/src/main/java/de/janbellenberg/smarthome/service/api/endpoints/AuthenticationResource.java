package de.janbellenberg.smarthome.service.api.endpoints;

import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.Produces;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.bson.types.ObjectId;

import static com.mongodb.client.model.Filters.*;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import de.janbellenberg.smarthome.base.MongoConnectionManager;
import de.janbellenberg.smarthome.base.annotations.Secured;
import de.janbellenberg.smarthome.base.helper.security.PasswordHelper;
import de.janbellenberg.smarthome.base.helper.security.SecurityHelper;
import de.janbellenberg.smarthome.dao.UsersDAO;
import de.janbellenberg.smarthome.model.User;
import de.janbellenberg.smarthome.service.api.AuthenticationFilter;

@Singleton
@Path("/auth")
public class AuthenticationResource {

  @Inject
  UsersDAO dao;

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response performLogin(JsonObject request) {
    int uid = request.getInt("uid");
    String password = request.getString("password");
    User user = this.dao.getUserById(uid);

    if (user == null) {
      return Response.status(Status.UNAUTHORIZED).build();
    }

    // check password
    boolean success = PasswordHelper.matchPassword(password, user.getLocalUser().getPassword(),
        user.getLocalUser().getSalt());

    if (!success) {
      return Response.status(Status.UNAUTHORIZED).build();
    }

    // generate session id
    MongoCollection<Document> coll = MongoConnectionManager.getInstance().getSessionCollection();
    String sessionID;
    do {
      sessionID = SecurityHelper.generateSecureRandomString(50);
    } while (coll.find(eq("id", sessionID)).first() != null);

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ssZ");

    // create session in mongodb
    Document session = new Document("_id", new ObjectId());
    session.append("id", sessionID);
    session.append("uid", user.getId());
    session.append("started", dtf.format(ZonedDateTime.now()));

    coll.insertOne(session);

    return Response.ok().entity(Json.createObjectBuilder().add("sessionID", sessionID).build()).build();
  }

  @DELETE
  @Secured
  public Response performLogout(@HeaderParam(AuthenticationFilter.HEADER_NAME) final String sessionID) {
    MongoCollection<Document> coll = MongoConnectionManager.getInstance().getSessionCollection();
    coll.deleteOne(eq("id", sessionID));

    return Response.ok().build();
  }
}
