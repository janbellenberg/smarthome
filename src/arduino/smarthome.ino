#include <EEPROM.h>
#include <stdlib.h>
#include <string.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoWebsockets.h>

#include "smarthome_eeprom.h"
#include "state.h"

using namespace websockets;

#define SERVER "192.168.137.193"
#define PORT 8443

char *SSID;
char *KEY;
char *JWT;

WebsocketsClient client;
State state(applyUpdatedConfig);

const char *configPattern = "{\"sections\":[{\"name\":\"Allgemein\",\"properties\":[{\"label\":\"LED an/aus\",\"value\":{led_val},\"type\":4,\"id\":\"led_state\",\"mode\":\"instant\"}]}]}";
const char *setupData = "{\"name\": \"D1 Mini\",\"type\": \"lgt\",\"description\": \"Test\",\"vendor\": \"Jan Bellenberg\",\"defaultCommand\": \"led_toggle\"}";

void setup()
{
  // init system
  Serial.begin(9600);
  EEPROM.begin(4096);
  pinMode(LED_BUILTIN, OUTPUT);
  state.setLED(false);

  // enable debugging
  Serial.setDebugOutput(true);

  // setup websocket client
  client.onMessage(onMessageCallback);
  client.onEvent(onEventsCallback);
  client.setInsecure();

  // read to global vars
  EEPROM_CONFIG conf = readEEPROM();
  SSID = conf.SSID;
  KEY = conf.KEY;
  JWT = conf.JWT;
  Serial.println(SSID);
  Serial.println(KEY);
  Serial.println(WiFi.macAddress());

  // connect to wifi
  WiFi.begin(SSID, KEY);
  while (WiFi.status() != WL_CONNECTED)
    delay(100);

  // check, if server has all credentials
  String baseUrl = "https://";
  baseUrl.concat(SERVER);

  WiFiClientSecure httpClient;
  httpClient.setInsecure();
  httpClient.connect(baseUrl, PORT);

  HTTPClient http;
  baseUrl.concat(":");
  baseUrl.concat(PORT);

  http.begin(httpClient, (baseUrl + "/smarthome-api/devices/" + WiFi.macAddress() + "/is-setup-done").c_str());
  int httpCode = http.GET();
  http.end();

  // HTTP 204 -> No Content -> Server misses information
  if (httpCode == 204)
  {
    free(JWT);

    http.begin(httpClient, (baseUrl + "/smarthome-api/devices/" + WiFi.macAddress() + "/configure").c_str());
    http.addHeader("Content-Type", "application/json");
    http.POST(setupData);
    String jwt = http.getString();
    http.end();

    JWT = (char *)malloc(jwt.length());
    strcpy(JWT, jwt.c_str());
    write(SSID, KEY, JWT);
  }

  // Connect to server via websocket
  client.connectSecure(SERVER, PORT, buildSocketLink().c_str());
}

void loop()
{
  if (client.available())
  {
    client.poll();
  }
  else
  {
    Serial.println("reconnect");
    client.connectSecure(SERVER, PORT, buildSocketLink().c_str());
    delay(1000);
  }
}

void onMessageCallback(WebsocketsMessage message)
{
  if (strstr(message.c_str(), "led_state"))
  {
    if (strstr(message.c_str(), "true"))
    {
      client.send("#led_state:true\n+LED an");
      state.setLED(true);
    }
    else
    {
      client.send("#led_state:false\n+LED aus");
      state.setLED(false);
    }
  }
  else if (strstr(message.c_str(), "led_toggle"))
  {
    state.setLED(!state.getLED());
    client.send("#led_toggle\n+OK");
  }
  else
  {
    String msg = message.c_str();
    String errorResponse = "#" + msg + "\n-";
    client.send(errorResponse.c_str());
  }
}

void onEventsCallback(WebsocketsEvent event, String data)
{
  if (event == WebsocketsEvent::ConnectionOpened)
  {
    Serial.println("open");
  }
  else if (event == WebsocketsEvent::ConnectionClosed)
  {
    Serial.println("close");
  }
}

void on()
{
  digitalWrite(LED_BUILTIN, LOW);
}

void off()
{
  digitalWrite(LED_BUILTIN, HIGH);
}

void writeDemoToEEPROM()
{
  char ssid[] = "Jan";
  char key[] = "jHgi0geWHwvsg8ks";
  char jwt[] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTUxNjIzOTAyMn0.oGerxycgfnwFt6BmZKVfbtDvEY-pXoTCvYMPDWDA5r0";
  write(ssid, key, jwt);
}

String buildSocketLink()
{
  String url = "/smarthome-api/device/socket?token=";
  url += JWT;
  return url;
}

void applyUpdatedConfig()
{
  String config = configPattern;
  config.replace("{led_val}", state.getLED() ? "true" : "false");
  client.send(config);

  if (state.getLED())
    on();
  else
    off();
}