import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/services/api/auth.dart' as service;

void login(String uid, String password) async {
  Map<String, dynamic>? result = await performApiOperation(
    () => service.login(int.parse(uid), password),
  );

  if (result == null) {
    return;
  }

  store.dispatch(new Action(ActionTypes.updateSessionID, result["sessionID"]));
}

void logout() async {
  Map<String, dynamic>? result = await performApiOperation(
    () => service.logout(),
  );

  if (result != null) {
    store.dispatch(new Action(ActionTypes.updateSessionID, null));
  }
}
