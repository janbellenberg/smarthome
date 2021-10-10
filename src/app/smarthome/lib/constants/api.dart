import 'package:Smarthome/models/rest_resource.dart';

enum HTTPMethod { GET, POST, PUT, PATCH, DELETE }
enum HTTPError {
  CLIENT_ERROR,
  SERVER_ERROR,
  NOT_AUTHORIZED,
  DEPRECATED,
  CONNECTION_ERROR
}

const String JSON_MIME = "application/json";

const bool USE_TLS = true;
const String HOSTNAME = "10.0.2.2";
const String PORT = USE_TLS ? "8443" : "8080";

const String BASE_URL = (USE_TLS ? "https" : "http") +
    "://" +
    HOSTNAME +
    ":" +
    PORT +
    "/smarthome-api";

RestResource LOGIN = new RestResource(
  HTTPMethod.POST,
  "/auth",
  responseData: true,
  useToken: false,
);
