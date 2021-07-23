package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.NotSupportedException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for not supported exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class NotSupportedMapper implements ExceptionMapper<NotSupportedException> {

	/**
	 * build a response with an error message to tell the client the request can't
	 * be processed
	 */
	@Override
	public Response toResponse(NotSupportedException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Die Anfrage kann in dieser Form nicht bearbeitet werden");
		builder.add("detail", "NOT_SUPPORTED");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(406).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
