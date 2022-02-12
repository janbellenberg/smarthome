enum ActionTypes {
  updateSelectedBuilding,
  updateSelectedRoom,
  updateSessionID,
  updateUsername,
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
  clearDevices,
  addShortcut,
  clearShortcuts,
}

class Action {
  ActionTypes type;
  dynamic payload;

  Action(this.type, {this.payload = null});
}
