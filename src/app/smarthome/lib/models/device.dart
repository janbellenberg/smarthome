import '../constants/device_types.dart';
import 'section.dart';

class Device {
  int? ID;
  String name;
  DeviceType? type;
  String description;
  String vendor;
  String mac;
  String local;
  int room;
  String status;

  List<Section> sections = new List.empty(growable: true);

  Device(this.name, this.type, this.description, this.vendor, this.mac,
      this.local, this.room,
      {this.status = "Offline"});

  Device.fromDB(this.ID, this.name, this.type, this.description, this.vendor,
      this.mac, this.local, this.room,
      {this.status = "Offline"});
}
