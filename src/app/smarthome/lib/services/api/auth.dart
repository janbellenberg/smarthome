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

dynamic signUp(
  String firstname,
  String lastname,
  String email,
  String password,
) async {
  return await HTTP.fetch(
    SIGN_UP
      ..requestData = {
        "firstname": firstname,
        "lastname": lastname,
        "localUser": {
          "email": email,
          "password": password,
        }
      },
  );
}
