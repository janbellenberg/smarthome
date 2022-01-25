import '../constants/device_types.dart';
import 'section.dart';

class Device {
  int? ID;
  late String name;
  DeviceType? type;
  late String description;
  late String vendor;
  late String mac;
  late String local;
  late bool online;
  String? defaultCommand;

  List<Section> sections = new List.empty(growable: true);

  Device(
    this.name,
    this.type,
    this.description,
    this.vendor,
    this.mac,
    this.local, {
    this.online = false,
  });

  Device.fromDB(Map<String, dynamic> data) {
    this.ID = data["id"];
    this.name = data["name"] ?? "Unbekannt";
    this.description = data["description"] ?? "";
    this.vendor = data["vendor"] ?? "";
    this.defaultCommand = data["defaultCommand"];
    this.mac = data["mac"] ?? "";
    this.local = data["local"] ?? "";
    this.online = data["online"] ?? false;

    this.type = typeID.keys.firstWhere(
      (key) => typeID[key] == data["type"],
      orElse: null,
    );
  }
}
