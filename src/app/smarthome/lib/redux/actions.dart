enum ActionTypes {
  updateSessionID,
  updateWaiting,
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

  Action(this.type, this.payload);
}
