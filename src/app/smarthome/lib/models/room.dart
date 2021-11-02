import 'package:Smarthome/models/device.dart';

class Room {
  int? ID;
  late String name;
  late int building;

  List<Device> devices = List.empty(growable: true);

  Room(this.name, this.building);
  Room.fromDB(Map<String, dynamic> data, int building) {
    this.ID = data["id"] ?? -1;
    this.name = data["name"] ?? "";
    this.building = building;
  }
}
