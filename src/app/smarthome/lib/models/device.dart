import '../constants/device_types.dart';

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

  Device(this.name, this.type, this.description, this.vendor, this.mac,
      this.local, this.room,
      {this.status = "Offline"});

  Device.fromDB(this.ID, this.name, this.type, this.description, this.vendor,
      this.mac, this.local, this.room,
      {this.status = "Offline"});
}
