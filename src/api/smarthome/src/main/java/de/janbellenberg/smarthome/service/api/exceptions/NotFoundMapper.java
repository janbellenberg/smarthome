package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for 404 Not Found exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class NotFoundMapper implements ExceptionMapper<NotFoundException> {

	/**
	 * build a response with an error message and tell the client the resource could
	 * not be found
	 */
	@Override
	public Response toResponse(NotFoundException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message",
				"Die angeforderte Resource konnte nicht gefunden werden. Vielleicht ist die Schnittstelle veraltet.");
		builder.add("category", "web");
		builder.add("error", true);
		return Response.status(Status.NOT_FOUND).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
