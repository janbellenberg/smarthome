import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/services/api/users.dart' as service;

Future<void> loadUsername() async {
  Map<String, dynamic>? result = await runApiService(
    () => service.loadUserInfos(),
  );

  if (result == null) {
    return;
  }

  store.dispatch(
    new Action(
      ActionTypes.updateUsername,
      payload: result["firstname"],
    ),
  );
}
