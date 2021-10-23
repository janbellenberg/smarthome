import 'building.dart';

class AppState {
  String? sessionID = null;
  bool waiting = false;
  List<Building> buildings = List.empty(growable: true);
}
