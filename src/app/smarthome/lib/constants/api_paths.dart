const bool USE_TLS = true;
const String HOSTNAME = "10.0.2.2";
const String PORT = USE_TLS ? "8443" : "8080";

const String BASE_URL = (USE_TLS ? "https" : "http") +
    "://" +
    HOSTNAME +
    ":" +
    PORT +
    "/smarthome-api";
