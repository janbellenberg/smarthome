package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.NotAcceptableException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for 406 Not Acceptable exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class NotAcceptableMapper implements ExceptionMapper<NotAcceptableException> {

	/**
	 * build a response with an error message to tell the client the request is
	 * wrong
	 */
	@Override
	public Response toResponse(NotAcceptableException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message",
				"Die Anfrage kann in dieser Form nicht bearbeitet werden. Vielleicht ist die Schnittstelle veraltet.");
		builder.add("detail", "NOT_ACCEPTABLE");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(406).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
