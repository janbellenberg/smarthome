import 'package:Smarthome/models/device.dart';

class Room {
  int? ID;
  String name;
  int building;

  List<Device> devices = List.empty(growable: true);

  Room(this.name, this.building);
  Room.fromDB(this.ID, this.name, this.building);
}
