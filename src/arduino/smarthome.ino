#include <EEPROM.h>
#include <stdlib.h>

void write(char *ssid, char *key, char *jwt);
void read();

char *SSID;
char *KEY;
char *JWT;

const char ddcp[] = "{'name':'LED','isNameEditable':false,'description':'Testmodul für eine LED','type':'l','vendor':'Jan Bellenberg','sections':[{'name':'Allgemein','properties':[{'label':'LED an/aus','value':true,'type':4,'id':'led_state','mode':'instant'}]}]}";
const char ping[] = "{'name':'LED','description':'Testmodul für eine LED','type':'l'}";

void setup()
{
  // init system
  Serial.begin(9600);
  EEPROM.begin(4096);

  // write data to eeprom
  char ssid[] = "Jan";
  char key[] = "jHgi0geWHwvsg8ks";
  char jwt[] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
  write(ssid, key, jwt);

  // read to global vars
  read();
}

size_t getSize(char *p)
{
  size_t s = 0;
  do
  {
    s++;
  } while (*(p + s) != '\0');
  return (s + 1);
}

void write(char *ssid, char *key, char *jwt)
{
  int addr = 0;

  int ssidLen = getSize(ssid);
  int keyLen = getSize(key);
  int jwtLen = getSize(jwt);

  EEPROM.put(addr, ssidLen);
  addr += 4;
  EEPROM.put(addr, keyLen);
  addr += 4;
  EEPROM.put(addr, jwtLen);
  addr += 4;

  // SSID
  for (int i = 0; i < ssidLen; i++)
  {
    EEPROM.put(addr + i, *(ssid + i));
  }
  addr += ssidLen;

  // KEY
  for (int i = 0; i < keyLen; i++)
  {
    EEPROM.put(addr + i, *(key + i));
  }
  addr += keyLen;

  // JWT
  for (int i = 0; i < jwtLen; i++)
  {
    EEPROM.put(addr + i, *(jwt + i));
  }
  addr += jwtLen;

  // commit data
  EEPROM.commit();
}

void read()
{
  // data data length
  int ssidLen = EEPROM.read(0);
  int keyLen = EEPROM.read(4);
  int jwtLen = EEPROM.read(8);

  int addr = 4 * 3;

  // allocate data
  SSID = (char *)calloc(ssidLen, sizeof(char));
  KEY = (char *)calloc(keyLen, sizeof(char));
  JWT = (char *)calloc(jwtLen, sizeof(char));

  // read ssid
  for (int i = 0; i < ssidLen; i++)
  {
    SSID[i] = char(EEPROM.read(i + addr));
  }
  addr += ssidLen;

  // read key
  for (int i = 0; i < keyLen; i++)
  {
    KEY[i] = char(EEPROM.read(i + addr));
  }
  addr += keyLen;

  // read jwt
  for (int i = 0; i < jwtLen; i++)
  {
    JWT[i] = char(EEPROM.read(i + addr));
  }
}

void loop()
{
}