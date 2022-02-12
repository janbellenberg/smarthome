#ifndef __SMARTHOME_STATE_H
#define __SMARTHOME_STATE_H

class State
{
public:
  void setLED(bool state);
  bool getLED();
  State(void(*onUpdate)());

private:
  bool ledState;
  void (*onUpdate)();
};

#endif