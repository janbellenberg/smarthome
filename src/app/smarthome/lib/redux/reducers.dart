import '../models/app_state.dart';
import '../models/building.dart';
import '../models/room.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action.type == ActionTypes.updateSessionID) {
    state.sessionID = action.payload;
  } else if (action.type == ActionTypes.updateWaiting) {
    state.waiting = action.payload;
  } else if (action.type == ActionTypes.updateWeather) {
    state.buildings
        .firstWhere(
          (element) => element.ID == action.payload["building"],
          orElse: () => new Building.fromDB({}),
        )
        .weather = action.payload["weather"];
  } else if (action.type == ActionTypes.setOffline) {
    state.serverAvailable = false;
  } else if (action.type == ActionTypes.addBuilding) {
    state.buildings.add(action.payload);
  } else if (action.type == ActionTypes.clearBuildings) {
    state.buildings.clear();
  } else if (action.type == ActionTypes.addRoom) {
    state.buildings
        .firstWhere(
          (element) => element.ID == action.payload.building,
          orElse: () => new Building.fromDB({}),
        )
        .rooms
        .add(action.payload);
  } else if (action.type == ActionTypes.clearRooms) {
    state.buildings
        .firstWhere(
          (element) => element.ID == action.payload,
          orElse: () => new Building.fromDB({}),
        )
        .rooms
        .clear();
  } else if (action.type == ActionTypes.addDevice) {
    state.buildings.forEach((building) {
      Room result = building.rooms.firstWhere(
        (room) => room.ID = action.payload.room,
        orElse: () => new Room.fromDB({}, 0),
      );

      if ((result.ID ?? 0) > 0) {
        building.rooms
            .firstWhere(
              (room) => room.ID = action.payload.room,
              orElse: () => new Room.fromDB({}, 0),
            )
            .devices
            .add(action.payload);
      }
    });
  } else if (action.type == ActionTypes.clearDevices) {
    state.buildings
        .firstWhere(
          (element) => element.ID == action.payload.building,
          orElse: () => new Building.fromDB({}),
        )
        .rooms
        .clear();
  }

  return state;
}
