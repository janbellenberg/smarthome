import '../constants/device_types.dart';

class Device {
  int? ID;
  String name;
  DeviceType type;
  String description;
  String vendor;
  String mac;
  String local;
  int room;

  Device(this.name, this.type, this.description, this.vendor, this.mac,
      this.local, this.room);

  Device.fromDB(this.ID, this.name, this.type, this.description, this.vendor,
      this.mac, this.local, this.room);
}
