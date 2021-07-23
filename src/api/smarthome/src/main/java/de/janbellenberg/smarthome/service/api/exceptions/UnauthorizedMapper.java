package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for 401 Unauthorized exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class UnauthorizedMapper implements ExceptionMapper<NotAuthorizedException> {

	/**
	 * build a response with unauthorized error message
	 */
	@Override
	public Response toResponse(NotAuthorizedException exception) {
		int status = exception.getResponse() == null ? 401 : exception.getResponse().getStatus();

		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Sie sind für diese Anfrage nicht berechtigt");
		builder.add("detail", "UNAUTHORIZED");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(status).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
