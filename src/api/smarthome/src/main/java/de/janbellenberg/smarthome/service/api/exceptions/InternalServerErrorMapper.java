package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.InternalServerErrorException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for 500 Internal Server Error exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class InternalServerErrorMapper implements ExceptionMapper<InternalServerErrorException> {

	/**
	 * build a response with an error message to tell the client an error occurred
	 * on the server
	 */
	@Override
	public Response toResponse(InternalServerErrorException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Auf dem Server ist ein unbekannter Fehler aufgetreten");
		builder.add("detail", "INTERNAL_SERVER_ERROR");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(500).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
