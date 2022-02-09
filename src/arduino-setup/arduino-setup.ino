// IP: 192.168.4.1

#include <EEPROM.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>

#include "smarthome_eeprom.h"

#define HOME "<!DOCTYPE html><html lang='de'><head> <title>Smarthome</title> <meta name='viewport' content='width=device-width, initial-scale=1'> <link href='style.css' rel='stylesheet'/> <script src='code.js' defer></script></head><body> <h1>Mit WLAN verbinden</h1> <input type='button' onclick='refresh();' value='Liste aktualisieren'/> <div id='wifi-list'> </div></body></html>"
#define STYLES "*{font-family:Calibri,Arial,sans-serif}h1{color:#528e75}input[type=button]{font-size:1.1em;background:#528e75;color:#fff;border:none;border-radius:50px;padding:7px 15px;cursor:pointer}div#wifi-list{border:2px solid #528e75;border-radius:20px;color:#000;background:#fff;padding:1em;margin:.5em;max-width:400px}div.list-item{margin:1em 0;padding:.5em 1em;box-shadow:0 0 20px #d3d3d3;border-radius:15px;cursor:pointer}"
#define CODE "let refresh=async()=>{let e=await fetch('/get-wifis'),i=await e.json(),t=document.querySelector('#wifi-list');t.innerHTML='';i.sort((a, b) => (parseInt(a.strength) > parseInt(b.strength) ? -1 : 1));i.forEach(e=>{var i=document.createElement('div');i.classList.add('list-item'),i.innerText=e.ssid,i.onclick=(async()=>{let i=prompt('Bitte geben Sie das Passwort ein:');await saveWifi(e.ssid,i),document.querySelector('body').innerHTML='<h1>Erledigt!</h1>'}),t.appendChild(i)}),i.length<1&&(t.innerHTML='Keine WLAN-Netzwerke gefunden')},saveWifi=async(e,i)=>{let t={ssid:e,key:i};await fetch('/save-config',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(t)})};refresh();"

void getIndexPage();
void getStyles();
void getJsCode();
void listWifis();
void saveConfig();

ESP8266WebServer server(80);

void setup()
{
  EEPROM.begin(4096);

  Serial.begin(9600);
  Serial.setDebugOutput(true);

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

void loop()
{
  server.handleClient();
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
  write((char*)ssid, (char*)key, empty);
  Serial.println(ssid);
  Serial.println(key);

  server.send(200, "text/plain", "");
  WiFi.softAPdisconnect(true);
}