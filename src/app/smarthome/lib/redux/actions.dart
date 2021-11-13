enum ActionTypes {
  updateSessionID,
  startTask,
  stopTask,
  setupDone,
  updateWeather,
  setOffline,
  addBuilding,
  clearBuildings,
  addRoom,
  clearRooms,
  addDevice,
  clearDevices
}

class Action {
  ActionTypes type;
  dynamic payload;

  Action(this.type, {this.payload = null});
}
