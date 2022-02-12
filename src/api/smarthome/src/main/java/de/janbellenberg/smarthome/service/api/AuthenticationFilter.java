package de.janbellenberg.smarthome.service.api;

import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ResourceInfo;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.Provider;

import com.mongodb.client.MongoCollection;

import org.bson.Document;

import static com.mongodb.client.model.Filters.*;

import java.lang.reflect.Method;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import de.janbellenberg.smarthome.base.MongoConnectionManager;
import de.janbellenberg.smarthome.base.annotations.Secured;

@Provider
public class AuthenticationFilter implements ContainerRequestFilter {

  @Context
  private ResourceInfo resourceInfo;

  public static final String HEADER_NAME = "smarthome-session";
  public static final String UID_HEADER_NAME = "X-UID";

  @Override
  public void filter(ContainerRequestContext requestContext) {
    Response unauthorized = Response.status(Status.UNAUTHORIZED).build();

    if (requestContext.getHeaders().containsKey(UID_HEADER_NAME)) {
      requestContext.getHeaders().remove(UID_HEADER_NAME);
    }

    Method method = resourceInfo.getResourceMethod();
    if (!method.isAnnotationPresent(Secured.class)) {
      return;
    }

    // check if header exists
    final String sessionID = requestContext.getHeaderString(HEADER_NAME);
    if (sessionID == null) {
      throw new NotAuthorizedException(unauthorized);
    }

    // check for session id in mongodb
    MongoCollection<Document> coll = MongoConnectionManager.getInstance().getSessionCollection();
    Document session = coll.find(eq("id", sessionID)).first();
    if (session == null) {
      throw new NotAuthorizedException(unauthorized);
    }

    // check if session is expired
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ssZ");
    ZonedDateTime started = ZonedDateTime.parse(session.get("started").toString(), dtf);
    ZonedDateTime now = LocalDateTime.now().atZone(ZoneId.systemDefault()).minusYears(1); // session should expire after
                                                                                          // one year

    if (!Duration.between(started, now).isNegative()) {
      // delete session if expired
      coll.deleteOne(eq("id", sessionID));
      throw new NotAuthorizedException(unauthorized);
    }

    // add user id to header for usage in endpoints
    requestContext.getHeaders().add(UID_HEADER_NAME, session.get("uid").toString());
  }
}
