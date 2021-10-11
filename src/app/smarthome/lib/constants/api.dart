import 'package:Smarthome/models/rest_resource.dart';

enum HTTPMethod { GET, POST, PUT, PATCH, DELETE }
enum HTTPError {
  CLIENT_ERROR,
  SERVER_ERROR,
  NOT_AUTHORIZED,
  DEPRECATED,
  CONNECTION_ERROR
}

const int HTTP_OK = 200;
const int HTTP_CREATED = 201;
const int HTTP_NO_CONTENT = 204;

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

// AUTH //

RestResource LOGIN = new RestResource(
  HTTPMethod.POST,
  "/auth",
  useToken: false,
  responseData: true,
);

RestResource LOGOUT = new RestResource(
  HTTPMethod.DELETE,
  "/auth",
  expectedStatus: HTTP_NO_CONTENT,
);

// BUILDINGS //

RestResource GET_BUILDINGS = new RestResource(
  HTTPMethod.GET,
  "/buildings",
  responseData: true,
);

RestResource ADD_BUILDING = new RestResource(
  HTTPMethod.POST,
  "/buildings",
  expectedStatus: HTTP_CREATED,
);

RestResource UPDATE_BUILDING = new RestResource(
  HTTPMethod.PUT,
  "/buildings/{id}",
);

RestResource DELETE_BUILDING = new RestResource(
  HTTPMethod.DELETE,
  "/buildings/{id}",
  expectedStatus: HTTP_NO_CONTENT,
);

// DEVICES //

RestResource GET_DEVICES = new RestResource(
  HTTPMethod.GET,
  "/rooms/{rid}/devices",
  responseData: true,
);

RestResource ADD_DEVICE = new RestResource(
  HTTPMethod.POST,
  "/rooms/{rid}/devices/{id}",
  expectedStatus: HTTP_CREATED,
);

RestResource DELETE_DEVICE = new RestResource(
  HTTPMethod.DELETE,
  "/rooms/{rid}/devices/{id}",
  expectedStatus: HTTP_NO_CONTENT,
);

// MEMBERS //

RestResource ENTER_BUILDING = new RestResource(
  HTTPMethod.POST,
  "/building/{bid}/members",
  expectedStatus: HTTP_CREATED,
);

RestResource LEAVE_BUILDING = new RestResource(
  HTTPMethod.DELETE,
  "/building/{bid}/members",
  expectedStatus: HTTP_NO_CONTENT,
);

// ROOMS //

RestResource GET_ROOMS = new RestResource(
  HTTPMethod.GET,
  "/buildings/{bid}/rooms",
  responseData: true,
);

RestResource ADD_ROOM = new RestResource(
  HTTPMethod.POST,
  "/buildings/{bid}/rooms",
  expectedStatus: HTTP_CREATED,
);

RestResource UPDATE_ROOM = new RestResource(
  HTTPMethod.PUT,
  "/buildings/{bid}/rooms/{id}",
);

RestResource DELETE_ROOM = new RestResource(
  HTTPMethod.DELETE,
  "/buildings/{bid}/rooms/{id}",
  expectedStatus: HTTP_NO_CONTENT,
);

// SHORTCUTS //

RestResource GET_SHORTCUTS = new RestResource(
  HTTPMethod.GET,
  "/buildings/{id}/shortcuts",
  responseData: true,
);

// USERS //

RestResource GET_USER = new RestResource(
  HTTPMethod.GET,
  "/user",
  responseData: true,
);

RestResource ADD_USER = new RestResource(
  HTTPMethod.POST,
  "/user/local",
  expectedStatus: HTTP_CREATED,
);

RestResource UPDATE_USER = new RestResource(
  HTTPMethod.PATCH,
  "/user",
);

RestResource DELETE_USER = new RestResource(
  HTTPMethod.DELETE,
  "/user",
  expectedStatus: HTTP_NO_CONTENT,
);
