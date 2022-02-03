import 'building.dart';

class AppState {
  String? sessionID = null;
  String? username = null;
  int runningTasks = 0;
  bool setupDone = false;
  bool serverAvailable = true;
  int selectedBuilding = 0;
  int? selectedRoom;
  List<Building> buildings = List.empty(growable: true);
}
