package de.janbellenberg.smarthome.service.api.exceptions;

import java.sql.SQLIntegrityConstraintViolationException;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for constraint violation exceptions (jpa)
 * 
 * @author janbellenberg
 *
 */
@Provider
public class ConstraintValidationMapper implements ExceptionMapper<SQLIntegrityConstraintViolationException> {

	/**
	 * build a response with an error message to tell the user a constraint
	 * violation occurred
	 */
	@Override
	public Response toResponse(SQLIntegrityConstraintViolationException exception) {
		String error = "Die Anfrage entspricht nicht den Regeln der Datenbank";
		String msg = exception.getMessage().toLowerCase();

		if (msg.contains("foreign key constraint fails"))
			error = "Das angegebene Objekt wird noch verwendet";
		else if (msg.contains("duplicate entry"))
			error = "Mindestens ein Feld muss einmalig sein bzw. der Datensatz existiert bereits";

		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", error);
		builder.add("detail", "CONSTRAINT_VIOLATION");
		builder.add("category", "DB");
		builder.add("error", true);
		return Response.status(409) // conflict
				.entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
