#include <EEPROM.h>
#include <stdlib.h>
#include <string.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>

#include "smarthome_eeprom.h"
#include "state.h"

using namespace websockets;

#define SERVER "192.168.137.193"
#define PORT 8443

void onMessageCallback(WebsocketsMessage message);
void onEventsCallback(WebsocketsEvent event, String data);
void on();
void off();
void writeDemoToEEPROM();
String buildSocketLink();
void applyUpdatedConfig();

void getIndexPage();
void getStyles();
void getJsCode();
void listWifis();
void saveConfig();

char *SSID;
char *KEY;
char *JWT;

typedef enum
{
  CLIENT,
  SETUP
} Mode;

Mode mode;

ESP8266WebServer server(80);

WebsocketsClient client;
State state(applyUpdatedConfig);

// DDCP CONFIG
const char *configPattern = "{\"sections\":[{\"name\":\"Allgemein\",\"properties\":[{\"label\":\"LED an/aus\",\"value\":{led_val},\"type\":4,\"id\":\"led_state\",\"mode\":\"instant\"}]}]}";
const char *setupData = "{\"name\": \"D1 Mini\",\"type\": \"lgt\",\"description\": \"Test\",\"vendor\": \"Jan Bellenberg\",\"defaultCommand\": \"led_toggle\"}";
const char *shortcut1 = "{\"description\": \"LED an\",\"command\": \"led_state:true\"}";
const char *shortcut2 = "{\"description\": \"LED aus\",\"command\": \"led_state:false\"}";

// SETUP SERVER DOCS
const char *HOME = "<!DOCTYPE html><html lang='de'><head> <title>Smarthome</title> <meta name='viewport' content='width=device-width, initial-scale=1'> <link href='style.css' rel='stylesheet'/> <script src='code.js' defer></script></head><body> <h1>Mit WLAN verbinden</h1> <input type='button' onclick='refresh();' value='Liste aktualisieren'/> <div id='wifi-list'> </div></body></html>";
const char *STYLES = "*{font-family:Calibri,Arial,sans-serif}h1{color:#528e75}input[type=button]{font-size:1.1em;background:#528e75;color:#fff;border:none;border-radius:50px;padding:7px 15px;cursor:pointer}div#wifi-list{border:2px solid #528e75;border-radius:20px;color:#000;background:#fff;padding:1em;margin:.5em;max-width:400px}div.list-item{margin:1em 0;padding:.5em 1em;box-shadow:0 0 20px #d3d3d3;border-radius:15px;cursor:pointer}";
const char *CODE = "let refresh=async()=>{let e=await fetch('/get-wifis'),i=await e.json(),t=document.querySelector('#wifi-list');t.innerHTML='';i.sort((a, b) => (parseInt(a.strength) > parseInt(b.strength) ? -1 : 1));i.forEach(e=>{var i=document.createElement('div');i.classList.add('list-item'),i.innerText=e.ssid,i.onclick=(async()=>{let i=prompt('Bitte geben Sie das Passwort ein:');await saveWifi(e.ssid,i),document.querySelector('body').innerHTML='<h1>Erledigt!</h1>'}),t.appendChild(i)}),i.length<1&&(t.innerHTML='Keine WLAN-Netzwerke gefunden')},saveWifi=async(e,i)=>{let t={ssid:e,key:i};await fetch('/save-config',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(t)})};refresh();";

void setup()
{
  // init system
  Serial.begin(9600);
  EEPROM.begin(4096);
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(D2, INPUT_PULLUP);
  state.setLED(false);

  // enable debugging
  Serial.setDebugOutput(true);

  // check running mode
  mode = digitalRead(D2) == LOW ? CLIENT : SETUP;

  Serial.println(mode == CLIENT ? "Client" : "Setup");

  if (mode == CLIENT)
  {
    // SETUP DEFAULT CLIENT PROGRAM

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

      // send shortcut1
      http.begin(httpClient, (baseUrl + "/smarthome-api/devices/shortcut?token=" + JWT).c_str());
      http.addHeader("Content-Type", "application/json");
      http.POST(shortcut1);
      http.end();

      // send shortcut2
      http.begin(httpClient, (baseUrl + "/smarthome-api/devices/shortcut?token=" + JWT).c_str());
      http.addHeader("Content-Type", "application/json");
      http.POST(shortcut2);
      http.end();
    }

    // Connect to server via websocket
    client.connectSecure(SERVER, PORT, buildSocketLink().c_str());
  }
  else
  {
    // SETUP CONFIG AP AND SERVER
    WiFi.mode(WIFI_AP);
    WiFi.softAP("smarthome-setup", NULL);
    Serial.println(WiFi.softAPIP());

    server.on("/", getIndexPage);
    server.on("/style.css", getStyle);
    server.on("/code.js", getJsCode);
    server.on("/get-wifis", listWifis);
    server.on("/save-config", saveConfig);

    server.begin();
  }
}

void loop()
{
  if (mode == CLIENT)
  {
    // DO WEBSOCKET THINGS...
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
  else
  {
    // DO SETUP AP THINGS...
    server.handleClient();
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
    state.setLED(false);
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
  Serial.println(url);
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

void getIndexPage()
{
  server.send(200, "text/html", HOME);
}

void getStyle()
{
  server.send(200, "text/css", STYLES);
}

void getJsCode()
{
  server.send(200, "application/json", CODE);
}

void listWifis()
{
  WiFiClient client;
  int n = WiFi.scanNetworks();

  String jsonResult = "[";

  for (int i = 0; i < n; i++)
  {
    // skip own config wifi
    if (WiFi.SSID(i) == "smarthome-setup")
      continue;

    jsonResult += "{";

    // build ssid
    jsonResult += "\"ssid\":";
    jsonResult += "\"" + WiFi.SSID(i) + "\",";

    // check if wifi is encrypted
    jsonResult += "\"strength\":";
    jsonResult += "\"";
    jsonResult += WiFi.RSSI(i);
    jsonResult += "\"";

    jsonResult += "}";

    // add comma to all but the last
    if (i != n - 1)
      jsonResult += ",";
  }

  jsonResult += "]";

  server.send(200, "application/json", jsonResult.c_str());
}

void saveConfig()
{
  if (!server.hasArg("plain"))
  {
    server.send(400, "text/plain", "");
    return;
  }

  DynamicJsonDocument doc(1024);
  DeserializationError error = deserializeJson(doc, server.arg("plain"));

  if (error)
  {
    server.send(400, "text/plain", "");
    return;
  }

  char empty[] = "";
  const char *ssid = doc["ssid"];
  const char *key = doc["key"];
  write((char *)ssid, (char *)key, empty);
  Serial.println(ssid);
  Serial.println(key);

  server.send(200, "text/plain", "");
  WiFi.softAPdisconnect(true);
}