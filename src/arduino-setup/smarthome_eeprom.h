#ifndef __EEPROM_H
#define __EEPROM_H

typedef struct
{
  char *SSID;
  char *KEY;
  char *JWT;
} EEPROM_CONFIG;

void write(char *ssid, char *key, char *jwt);
EEPROM_CONFIG readEEPROM();

#endif