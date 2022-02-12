import 'package:Smarthome/constants/api.dart';
import 'base.dart';

Future<dynamic> loadRooms(int building) async {
  return await HTTP.fetch(GET_ROOMS
    ..parameters.addAll(
      {"bid": building.toString()},
    ));
}

Future<dynamic> addRoom(
  String name,
  int building,
) async {
  return await HTTP.fetch(ADD_ROOM
    ..requestData = {
      "name": name,
      "building": building,
    }
    ..parameters.addAll(
      {"bid": building.toString()},
    ));
}

Future<dynamic> updateRoom(
  int id,
  String name,
  int building,
) async {
  return HTTP.fetch(UPDATE_ROOM
    ..requestData = {
      "name": name,
      "building": building,
    }
    ..parameters.addAll({
      "bid": building.toString(),
      "id": id.toString(),
    }));
}

Future<dynamic> deleteBuilding(int id, int building) async {
  return await HTTP.fetch(DELETE_ROOM
    ..parameters.addAll(
      {
        "bid": building.toString(),
        "id": id.toString(),
      },
    ));
}
