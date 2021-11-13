import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/services/api/auth.dart' as service;
import 'package:Smarthome/services/shared_prefs/base.dart';

void login(String uid, String password) async {
  Map<String, dynamic>? result = await runApiService(
    () => service.login(int.parse(uid), password),
  );

  if (result == null) {
    return;
  }

  saveSessionID(result["sessionID"]);
  store.dispatch(
      new Action(ActionTypes.updateSessionID, payload: result["sessionID"]));
}

void logout() {
  saveSessionID(null);

  store.dispatch(new Action(ActionTypes.updateSessionID));

  runApiService(
    () => service.logout(),
  );
}
