import 'package:Smarthome/models/rest_resource.dart';

enum HTTPMethod { GET, POST, PUT, PATCH, DELETE }
enum HTTPError {
  CLIENT_ERROR,
  SERVER_ERROR,
  NOT_AUTHORIZED,
  DEPRECATED,
  CONNECTION_ERROR,
  PLATFORM_ERROR,
  UNKNOWN
}

Map<HTTPError, String> errorDescription = {
  HTTPError.CLIENT_ERROR: "Die Daten sind falsch oder die App ist veraltet",
  HTTPError.SERVER_ERROR: "Auf dem Server ist ein Fehler aufgetreten",
  HTTPError.NOT_AUTHORIZED: "Sie sind für diesen Vorgang nicht berechtigt",
  HTTPError.DEPRECATED: "Die Schnittstelle scheint veraltet zu sein",
  HTTPError.PLATFORM_ERROR: "Diese Plattform wird noch nicht unterstützt"
};

const int HTTP_OK = 200;
const int HTTP_CREATED = 201;
const int HTTP_NO_CONTENT = 204;

const String JSON_MIME = "application/json";

const bool USE_TLS = true;
const String HOSTNAME = "lnxsrv";
const String PORT = USE_TLS ? "8443" : "8080";

const String WEATHER_API_KEY = "b20d6931ba5b7dc2c9579f38d1d05264";

const String BASE_URL = (USE_TLS ? "https" : "http") +
    "://" +
    HOSTNAME +
    ":" +
    PORT +
    "/smarthome-api";

RestResource GET_INFO = new RestResource(
  HTTPMethod.GET,
  "/info",
  useToken: false,
  responseData: true,
);

// AUTH //

RestResource LOGIN = new RestResource(
  HTTPMethod.POST,
  "/auth",
  useToken: false,
  responseData: true,
);

RestResource SIGN_UP = new RestResource(
  HTTPMethod.POST,
  "/user/local",
  expectedStatus: HTTP_CREATED,
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

RestResource GET_JOIN_TOKEN = new RestResource(
  HTTPMethod.GET,
  "/buildings/join/{bid}",
  responseData: true,
);

RestResource JOIN_BUILDING = new RestResource(
  HTTPMethod.POST,
  "/buildings/join",
  expectedStatus: HTTP_CREATED,
);

// DEVICES //

RestResource GET_DEVICES = new RestResource(
  HTTPMethod.GET,
  "/devices/room/1",
  responseData: true,
);

RestResource ADD_DEVICE = new RestResource(
  HTTPMethod.POST,
  "/devices",
  expectedStatus: HTTP_CREATED,
);

RestResource DELETE_DEVICE = new RestResource(
  HTTPMethod.DELETE,
  "/devices/{id}",
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
  "/buildings/{bid}/shortcuts",
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
