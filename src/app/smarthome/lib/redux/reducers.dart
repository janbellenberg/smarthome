import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/models/room.dart';

import 'actions.dart';

String? sessionReducer(String? state, dynamic action) {
  if (action.type == ActionTypes.updateSessionID) {
    return action.payload;
  }

  return state;
}

List<Building> buildingReducer(List<Building> state, dynamic action) {
  if (action.type == ActionTypes.addBuilding) {
    state.add(action.payload);
    return state;
  } else if (action.type == ActionTypes.clearBuildings) {
    return <Building>[];
  } else if (action.type == ActionTypes.addRoom) {
    state
        .firstWhere(
          (element) => element.ID == action.payload.building,
          orElse: () => new Building("", "", "", "", ""),
        )
        .rooms
        .add(action.payload);
    return state;
  } else if (action.type == ActionTypes.clearRooms) {
    state
        .firstWhere(
          (element) => element.ID == action.payload.building,
          orElse: () => new Building("", "", "", "", ""),
        )
        .rooms
        .clear();
    return state;
  } else if (action.type == ActionTypes.addDevice) {
    state.forEach((building) {
      Room result = building.rooms.firstWhere(
        (room) => room.ID = action.payload.room,
        orElse: () => new Room.fromDB(-1, "", 0),
      );

      if ((result.ID ?? 0) > 0) {
        building.rooms
            .firstWhere(
              (room) => room.ID = action.payload.room,
              orElse: () => new Room.fromDB(-1, "", 0),
            )
            .devices
            .add(action.payload);
      }
    });
    return state;
  } else if (action.type == ActionTypes.clearDevices) {
    state
        .firstWhere(
          (element) => element.ID == action.payload.building,
          orElse: () => new Building("", "", "", "", ""),
        )
        .rooms
        .clear();
    return state;
  }

  return state;
}
