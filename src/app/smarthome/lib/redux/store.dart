import 'package:Smarthome/models/building.dart';
import 'package:redux/redux.dart';

import 'reducers.dart';

final Store<String?> sessionStore = Store<String?>(
  sessionReducer,
  initialState: null,
);

final Store<List<Building>> dataStore = Store<List<Building>>(
  buildingReducer,
  initialState: List.empty(growable: true),
);
