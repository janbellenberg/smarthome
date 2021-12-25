class Shortcut {
  int? ID;
  int building;
  late int device;
  late String description;
  late String command;

  Shortcut(this.building, this.device, this.description, this.command);
  Shortcut.fromDB(Map<String, dynamic> data, this.building) {
    this.ID = data["id"];
    this.description = data["description"];
    this.command = data["command"];
    this.device = data["deviceID"];
  }
}
