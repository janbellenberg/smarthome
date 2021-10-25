import 'building.dart';

class AppState {
  String? sessionID = null;
  bool waiting = false;
  bool serverAvailable = true;
  List<Building> buildings = List.empty(growable: true);
}
