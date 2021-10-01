import 'package:Smarthome/models/room.dart';

class Building {
  int? ID;
  String name;
  String street;
  String postcode;
  String city;
  String country = "Deutschland";

  List<Room> rooms = List.empty(growable: true);

  Building(this.name, this.street, this.postcode, this.city, this.country);
  Building.fromDB(
      this.ID, this.name, this.street, this.postcode, this.city, this.country);
}
