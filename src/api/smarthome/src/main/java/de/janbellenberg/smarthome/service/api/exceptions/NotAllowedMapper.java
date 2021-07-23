package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.NotAllowedException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for 405 Method Not Allowed exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class NotAllowedMapper implements ExceptionMapper<NotAllowedException> {

	/**
	 * build a response with an error message and tell the user the request if wrong
	 */
	@Override
	public Response toResponse(NotAllowedException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Die Anfrage ist fehlerhaft. Vielleicht ist die Schnittstelle veraltet.");
		builder.add("detail", "WRONG_METHOD");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(405).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
