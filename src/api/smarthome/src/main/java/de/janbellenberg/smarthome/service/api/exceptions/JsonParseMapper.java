package de.janbellenberg.smarthome.service.api.exceptions;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.json.stream.JsonParsingException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

/**
 * exception mapper for json parsing exceptions
 * 
 * @author janbellenberg
 *
 */
@Provider
public class JsonParseMapper implements ExceptionMapper<JsonParsingException> {

	/**
	 * build a response with an error message to tell the client the request payload
	 * is formed invalid
	 */
	@Override
	public Response toResponse(JsonParsingException exception) {
		JsonObjectBuilder builder = Json.createObjectBuilder();
		builder.add("message", "Das JSON-Format der Anfrage ist fehlerhaft. Vielleicht ist die Schnittstelle veraltet.");
		builder.add("detail", "JSON_PARSE");
		builder.add("category", "JSON");
		builder.add("error", true);
		return Response.status(422) // unprocessable entity
				.entity(builder.build()).type(MediaType.APPLICATION_JSON).build();
	}

}
