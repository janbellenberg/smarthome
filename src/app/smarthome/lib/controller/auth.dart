import 'dart:developer';

import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/services/api/auth.dart' as service;

void login(String uid, String password) async {
  dynamic result = await service.login(int.parse(uid), password);
  if (result.runtimeType == HTTPError) {
    log(result);
    return;
  }

  store.dispatch(new Action(ActionTypes.updateSessionID, result["sessionID"]));
}

void logout() async {
  dynamic result = await service.logout();
  if (result.runtimeType == HTTPError) {
    log(result.toString());
    return;
  }

  store.dispatch(new Action(ActionTypes.updateSessionID, null));
}
