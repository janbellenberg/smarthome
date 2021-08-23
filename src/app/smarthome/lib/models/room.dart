class Room {
  int? ID;
  String name;
  int building;

  Room(this.name, this.building);
  Room.fromDB(this.ID, this.name, this.building);
}
