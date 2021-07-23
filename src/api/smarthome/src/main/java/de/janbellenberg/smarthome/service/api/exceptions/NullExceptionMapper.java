package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for null pointer exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class NullExceptionMapper implements ExceptionMapper<NullPointerException> {

	/**
	 * build a response with an error message
	 */
	@Override
	public Response toResponse(NullPointerException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message",
				"Die Anfrage ist fehlerhaft. Vielleicht ist die Schnittstelle veraltet oder eine Information fehlt.");
		builder.add("detail", "NULL_POINTER; MISSING_INFORMATION");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(422).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
