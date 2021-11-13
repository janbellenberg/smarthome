import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/models/room.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';

import 'package:Smarthome/services/api/rooms.dart' as service;

Future<void> loadRooms(int building) async {
  List<dynamic>? result = await performApiOperation(
    () => service.loadRooms(building),
  );

  if (result == null) {
    return;
  }

  store.dispatch(new Action(ActionTypes.clearRooms, payload: building));

  result.forEach((element) {
    store.dispatch(new Action(
      ActionTypes.addRoom,
      payload: new Room.fromDB(element, building),
    ));
  });
}

Future<void> addRoom(String name, int building) async {
  await performApiOperation(() => service.addRoom(name, building));
  await loadRooms(building);
}

Future<void> updateRoom(int id, String name, int building) async {
  await performApiOperation(() => service.updateRoom(id, name, building));
  await loadRooms(building);
}

Future<void> deleteRoom(int id, int building) async {
  await performApiOperation(() => service.deleteBuilding(id, building));
  await loadRooms(building);
}
