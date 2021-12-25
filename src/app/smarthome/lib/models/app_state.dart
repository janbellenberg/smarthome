import 'building.dart';

class AppState {
  String? sessionID = null;
  int runningTasks = 0;
  bool setupDone = false;
  bool serverAvailable = true;
  int selectedBuilding = 0;
  List<Building> buildings = List.empty(growable: true);
}
