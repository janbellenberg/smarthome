#include <EEPROM.h>
#include <stdlib.h>

#include "smarthome_eeprom.h"

unsigned long getSize(char *p)
{
  unsigned long s = 0;
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

EEPROM_CONFIG readEEPROM()
{
  // data data length
  int ssidLen = EEPROM.read(0);
  int keyLen = EEPROM.read(4);
  int jwtLen = EEPROM.read(8);

  int addr = 4 * 3;

  EEPROM_CONFIG config;

  // allocate data
  config.SSID = (char *)calloc(ssidLen, sizeof(char));
  config.KEY = (char *)calloc(keyLen, sizeof(char));
  config.JWT = (char *)calloc(jwtLen, sizeof(char));

  // read ssid
  for (int i = 0; i < ssidLen; i++)
  {
    config.SSID[i] = (char)(EEPROM.read(i + addr));
  }
  addr += ssidLen;

  // read key
  for (int i = 0; i < keyLen; i++)
  {
    config.KEY[i] = (char)(EEPROM.read(i + addr));
  }
  addr += keyLen;

  // read jwt
  for (int i = 0; i < jwtLen; i++)
  {
    config.JWT[i] = (char)(EEPROM.read(i + addr));
  }

  return config;
}