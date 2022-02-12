#include <ArduinoWebsockets.h>
#include "state.h"

State::State(void(*onUpdate)())
{
  this->onUpdate = onUpdate;
}

void State::setLED(bool state)
{
  this->ledState = state;
  this->onUpdate();
}

bool State::getLED() {
  return this->ledState;
}