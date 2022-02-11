package de.janbellenberg.smarthome.core.helper.security;

import java.io.StringReader;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonReader;

/**
 * class for paring and generating json web tokens (JWTs) More information:
 * jwt.io
 * 
 * @author janbellenberg
 */
public class JWT {
  /**
   * used secret for hmac-sha256 signature
   */
  private final static String SECRET = "MIIEowIBAAKCAQEAxpBSYtw64+FI2ZCj588byovA7ziV5xEzUE5akPCsB8EJHig+9tVbWYM59PWWaS4WZmf6wkxs7/5i10Qi4EZS5u7AxpFTGWzWeJKWpTZQIVTNGUi3vpp0xjpXXZwZ9bpYCLG9pD51MREBDXmH1fAyiA11BqA2hxlkACAugHvNs0KLTV+/0w/UgHhV+xqlu9IBuV8XCesF9+3jDSyocuiBq1JSVn8LfVQ4sgMbq5F6/5tL7q8tkIL5Qv6HRrWz0me9YbuC0IK4K6U9xGXsAlOF3EkPNpk1/UbTYGNTIqriJOQFFyE/vdSmciyMJz+cuFV3B36YSYGSgDg+gbutDsZmMwIDAQABAoIBAQCSVtMhIQYV5Hb4QW1K7oyg3ha3N5Di1v5mdRiyMW3X2SCLJUYiTGQiuGACdO0BX4IKvx9EC2dOCMF3vTOm7q0ynUteDMSdvGTkP8TexgSQTBtMQxeIVfUyEtVInD9Vppwy7CvD3HQqUUnhUGwX9AqJ0sEovPLy5neY0B71ekjDjz7+CExYqER1/1jBm28B8hfF5S4X8Xvr24jGQBVLoGhDTsqjbqR6RT7xNCRVNEqTXCbQ4T+pEvyINZFWz83lfXhxLHRBlseQZv1eDoCZ5PKCMtHPilwHLV5I2qLTkzLW9wWVY5Cj5el5KCqFKtUUh0b8KQqVtBZN0lSiHqQ4wM4BAoGBAOfXCV1n3WGGZf4p6oszj3fHXLCnIfgMATcTV0eAsBvxEYYVUBiGUvHPTbzjMkBZ4UkFoYi6KU11Fakb3GuZ+y1Xx306Wj46oDPmd/Ll3usv5aSQkeLPDaxYBv26YI0KR/fRhpUNWFQIZqZoGjqtOLJCK99wB0G/epvqVecpeTdBAoGBANtBjRdXb0S0YrNmUEMVBw+4/su9t8wxIHu2n1GpczWEtHAlfQLReGtLrbrUXkwj0I65b5a/ZZ6vbtPiCf9zyizeXAv1CXQSvJX/tARjTOoC7E9vdO98cmh9MY1SzZ3KRQ/bMO1utQbhKtuFUv7I1jGTkIziungXbXY3Npa6IZRzAoGAQ8ITWJtMln5DPN9fT0PIgIdhzbdrNCW+DSy364vu7JuuNXPxLtnDUCz4WWZFf41FTKQ6q81M2PiJVh1wdHpScNQg17bAPUPBIqoPEIyidDZRdaFTIejF5ELt+CYKpe4FTqaMIO//ir/R0HzIfbG2ylKQpAMH++1MllkMtjzm0oECgYAoyekVjo6EmYpDFaWY1TCbHC9Kd+DZe8ovOaop5vwn2Kg4tMCs5YshatLHDvr77y29X4IC6VheTQSxJjv16fSSpEs7bjpz/YhX31n99vs4DZMos/NtGhmulpvBTsYxtI9kg8J2aUIEJZ9zdzoZbANs9abOjt9ht/oFJABjyfy1QQKBgAXT5DBOEq2+BjcfIjtuh7mz9tAzcTh+mbCoWfI+jnyFh5/zFk6b+EN4sxAVaqZeqwrVqUOlP+HVcJR5oSnn0LAs8W/NUbSiKjaEEI8yV3ZfCnKc5XG3hsLOFalr/SkhWoWdxU6QYAnLHZbjY9iPEwJrYCS88pyQf06YB7icwDeH";
  private final static String alg = "HS256";

  /**
   * constructor initialize jwt with header and payload
   * 
   * @param header  jwt header
   * @param payload jwt payload
   */
  private JWT(JsonObject header, JsonObject payload) {
    this.header = header;
    this.payload = payload;
  }

  private JsonObject header;
  private JsonObject payload;

  /**
   * generate jwt for the specified employee
   * 
   * @param user employee the jwt should be for
   * @return new jwt
   */
  public static JWT generate() {
    JsonObjectBuilder header = Json.createObjectBuilder();
    JsonObjectBuilder payload = Json.createObjectBuilder();

    // set header to default values
    header.add("alg", alg);
    header.add("typ", "JWT");

    // set payload
    // TODO: add user class
    // payload.add("sub", user.getId()); // get user id
    payload.add("iat", System.currentTimeMillis() / 1000L); // get current time

    JWT jwt = new JWT(header.build(), payload.build());
    return jwt;
  }

  /**
   * generate jwt for admin user
   * 
   * @return new jwt
   */
  public static JWT generateForAdmin() {
    JsonObjectBuilder header = Json.createObjectBuilder();
    JsonObjectBuilder payload = Json.createObjectBuilder();

    // set header params to default
    header.add("alg", alg);
    header.add("typ", "JWT");

    // set payload
    payload.add("sub", 0);
    payload.add("iat", System.currentTimeMillis() / 1000L);

    JWT jwt = new JWT(header.build(), payload.build());
    return jwt;
  }

  /**
   * parse jwt from string and validate signature
   * 
   * @param jwtData jwt in string format
   * @return parsed jwt
   * @throws NoSuchAlgorithmException if the jwt algorithm is unsupported
   */
  public static JWT parse(String jwtData) throws NoSuchAlgorithmException {
    String[] items = jwtData.split("\\.");

    if (items.length != 3)
      return null;

    // parse json
    JsonObject header = getFromBase64(items[0]);
    JsonObject payload = getFromBase64(items[1]);

    // check if algorithm is supported
    if (!header.containsKey("alg") || !header.getString("alg").equals(alg))
      throw new NoSuchAlgorithmException();

    // check if type is supported
    if (!header.containsKey("typ") || !header.getString("typ").equals("JWT"))
      throw new NoSuchAlgorithmException();

    // create jwt object
    JWT jwt = new JWT(header, payload);

    // check if signature is valid
    if (!jwt.getSignature().equals(items[2]))
      return null;

    return jwt;
  }

  /**
   * encode json object to base64 url string
   * 
   * @param data instance of json object
   * @return encoded string
   */
  private String getBase64(JsonObject data) {
    String json = data.toString();
    return Base64.getUrlEncoder().withoutPadding().encodeToString(json.getBytes());
  }

  /**
   * parse json object from base64 url string
   * 
   * @param data encoded data
   * @return parsed json object
   */
  private static JsonObject getFromBase64(String data) {
    String json = new String(Base64.getUrlDecoder().decode(data));
    JsonReader jsonReader = Json.createReader(new StringReader(json));
    JsonObject object = jsonReader.readObject();
    jsonReader.close();

    return object;
  }

  /**
   * build the signature for the jwt
   * 
   * @return base64 url encoded signature
   */
  private String getSignature() {
    try {
      String data = this.getBase64(this.header) + "." + this.getBase64(this.payload);
      byte[] hash = SECRET.getBytes();

      Mac sha256Hmac = Mac.getInstance("HmacSHA256");
      SecretKeySpec secretKey = new SecretKeySpec(hash, "HmacSHA256");
      sha256Hmac.init(secretKey);

      byte[] signedBytes = sha256Hmac.doFinal(data.getBytes());

      return Base64.getUrlEncoder().withoutPadding().encodeToString(signedBytes);
    } catch (NoSuchAlgorithmException | InvalidKeyException ex) {
      return null;
    }
  }

  @Override
  public String toString() {
    return this.getBase64(this.header) + "." + this.getBase64(this.payload) + "." + this.getSignature();
  }

  public JsonObject getHeader() {
    return header;
  }

  public JsonObject getPayload() {
    return payload;
  }

}
