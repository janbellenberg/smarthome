package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.ServiceUnavailableException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for service unavailable exception
 * 
 * @author janbellenberg
 *
 */
@Provider
public class ServiceUnavailableMapper implements ExceptionMapper<ServiceUnavailableException> {

	/**
	 * build a response with the error message
	 */
	@Override
	public Response toResponse(ServiceUnavailableException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Der Dienst steht zur Zeit nicht zur Verfügung");
		builder.add("detail", "UNAVAILABLE");
		builder.add("category", "REST");
		builder.add("error", true);
		return Response.status(500).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
