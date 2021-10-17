import 'package:Smarthome/constants/api.dart';

import 'base.dart';

dynamic login(int uid, String password) async {
  return await HTTP.fetch(
    LOGIN..requestData = {"uid": uid, "password": password},
  );
}

dynamic logout() {
  return HTTP.fetch(LOGOUT);
}
