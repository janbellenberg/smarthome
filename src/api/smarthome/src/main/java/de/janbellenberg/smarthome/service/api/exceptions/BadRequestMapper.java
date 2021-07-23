package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for 400 Bad Request exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class BadRequestMapper implements ExceptionMapper<BadRequestException> {

	/**
	 * build a response with an error message to tell the client the request is
	 * invalid
	 */
	@Override
	public Response toResponse(BadRequestException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message",
				"Die Anfrage kann in dieser Form nicht bearbeitet werden. Vielleicht ist die Schnittstelle veraltet.");
		builder.add("detail", "BAD_REQUEST");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(400).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
