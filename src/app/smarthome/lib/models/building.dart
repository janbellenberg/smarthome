import 'package:Smarthome/models/room.dart';
import 'package:Smarthome/models/shortcut.dart';

class Building {
  int? ID;
  late String name;
  late String street;
  late String postcode;
  late String city;
  String country = "Deutschland";
  String? weather;

  List<Room> rooms = List.empty(growable: true);
  List<Shortcut> shortcuts = List.empty(growable: true);

  Building(this.name, this.street, this.postcode, this.city, this.country);
  Building.fromDB(Map<String, dynamic> data) {
    this.ID = data["id"];
    this.name = data["name"] ?? "";
    this.street = data["street"] ?? "";
    this.postcode = data["postcode"] ?? "";
    this.city = data["city"] ?? "";
    this.country = data["country"] ?? "Deutschland";
  }
}
