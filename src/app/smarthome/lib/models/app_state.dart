import 'building.dart';

class AppState {
  String? sessionID = "";
  bool waiting = false;
  List<Building> buildings = List.empty(growable: true);
}
