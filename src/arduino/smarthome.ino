#include <EEPROM.h>
#include <stdlib.h>
#include <string.h>
#include <ESP8266WiFi.h>
#include <ArduinoWebsockets.h>

#include "smarthome_eeprom.h"
#include "state.h"

using namespace websockets;

#define SERVER "192.168.137.193"
#define MAC "e8:db:84:dc:d0:5c"

char *SSID;
char *KEY;
char *JWT;

WebsocketsClient client;
State state(sendUpdatedConfig);

const char *configPattern = "{\"sections\":[{\"name\":\"Allgemein\",\"properties\":[{\"label\":\"LED an/aus\",\"value\":{led_val},\"type\":4,\"id\":\"led_state\",\"mode\":\"instant\"}]}]}";

void setup()
{
  // init system
  Serial.begin(9600);
  EEPROM.begin(4096);
  pinMode(LED_BUILTIN, OUTPUT);
  off();

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

  // connect to wifi
  WiFi.begin(SSID, KEY);
  while (WiFi.status() != WL_CONNECTED)
    delay(100);

  // Connect to server
  client.connectSecure(SERVER, 8443, buildSocketLink());
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
    client.connectSecure(SERVER, 8443, buildSocketLink());
    delay(100);
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
      on();
    }
    else
    {
      client.send("#led_state:false\n+LED aus");
      state.setLED(false);
      off();
    }
  }
  else
  {
    char *errorResponse = (char *)malloc(strlen(message.c_str()) + 4);
    strcat(errorResponse, "");
    strcat(errorResponse, "#");
    strcat(errorResponse, message.c_str());
    strcat(errorResponse, "\n-");
    client.send(errorResponse);
    free(errorResponse);
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

char *buildSocketLink()
{
  char lnk[] = "/smarthome-api/device/socket?token=";
  char *url = (char *)malloc(strlen(lnk) + strlen(JWT) + 1);
  strcpy(url, ""); // clear string for fixing errors
  strcat(url, lnk);
  strcat(url, JWT);
  return url;
}

void sendUpdatedConfig()
{
  String config = configPattern;
  config.replace("{led_val}", state.getLED() ? "true" : "false");
  client.send(config);
}