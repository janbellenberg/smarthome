import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/models/building.dart';
import 'package:redux/redux.dart';

import 'reducers.dart';

final Store<AppState> store = Store<AppState>(
  appReducer,
  initialState: new AppState(),
);
