class Shortcut {
  int? ID;
  int building;
  int device;
  String description;
  String command;

  Shortcut(this.building, this.device, this.description, this.command);
  Shortcut.fromDB(
      this.ID, this.building, this.device, this.description, this.command);
}
