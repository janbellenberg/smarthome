package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.persistence.NoResultException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for no result exceptions (from jpa)
 * 
 * @author janbellenberg
 *
 */
@Provider
public class NoResultMapper implements ExceptionMapper<NoResultException> {

	/**
	 * build a response with an error message to tell the user that no data could be
	 * found in the db
	 */
	@Override
	public Response toResponse(NoResultException exception) {
		String error = "Es konnten keine Daten aus der Datenbank abgerufen werden";
		int code = 500;
		String msg = exception.getMessage().toLowerCase();

		if (msg.contains("no entity found for query")) {
			error = "Die Anfrage oder Daten in der Anfrage beziehen sich auf einen nicht gefundenen Datensatz";
			code = 404; // not found
		}

		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", error);
		builder.add("detail", "NO_RESULT");
		builder.add("category", "DB");
		builder.add("error", true);
		return Response.status(code).entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}
}
