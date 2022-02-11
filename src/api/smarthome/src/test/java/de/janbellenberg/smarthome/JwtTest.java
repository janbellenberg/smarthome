package de.janbellenberg.smarthome;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

import de.janbellenberg.smarthome.base.helper.security.JWT;

public class JwtTest {
  @Test
  public void testJwtValidation() {
    String jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTYxODM5NTYzOX0.fOLbQpfu_T7UV7HerWHrFJAWPiSTO8F9rh6wg90SHbI";
    JWT parsed = JWT.parse(jwt);
    Assertions.assertNotNull(parsed);
    Assertions.assertTrue(parsed.getPayload().containsKey("sub"));
    Assertions.assertEquals(1, parsed.getPayload().getInt("sub"));

    jwt = jwt.substring(0, jwt.length() - 2);
    Assertions.assertNull(JWT.parse(jwt));
    Assertions.assertNull(JWT.parse("invalid"));
  }
}
