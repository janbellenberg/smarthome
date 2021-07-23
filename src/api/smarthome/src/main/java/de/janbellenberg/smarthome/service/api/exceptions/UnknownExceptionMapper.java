package de.janbellenberg.smarthome.service.api.exceptions;

import javax.ws.rs.ext.ExceptionMapper;
import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;
import javax.ws.rs.ext.Providers;

/**
 * exception mapper for all exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class UnknownExceptionMapper implements ExceptionMapper<Throwable> {

	@Context
	Providers providers;

	/**
	 * search for more specific exception wrapper or build a Response with default
	 * error message
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Response toResponse(Throwable exception) {
		// search other exception mapper
		int depth = 0;
		ExceptionMapper mapper = null;
		Throwable t = null;
		do {
			t = exception.getCause();
			if (t == null)
				break;

			mapper = providers.getExceptionMapper(t.getClass());
			depth++;
		} while (mapper == null && depth < 10);

		if (t != null && mapper != null)
			return mapper.toResponse(t);

		exception.printStackTrace();

		// build default error message
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Ein unbekannter Fehler ist aufgetreten");
		builder.add("detail", "UNKNOWN");
		builder.add("category", "UNKNOWN");
		builder.add("error", true);
		return Response.status(500).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}
}