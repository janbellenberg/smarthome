import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/services/api/info.dart' as service;
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> checkAppVersion() async {
  Map<String, dynamic>? result = await runApiService(
    () => service.getInfo(),
  );

  if (result == null) {
    return;
  }

  double latestVersion = result["current_version"]["app"];

  dynamic pubspec = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  double currentVersion = double.parse(
    pubspec["version"].toString().split("+")[0],
  );

  if (currentVersion < latestVersion) {
    Fluttertoast.showToast(
      msg: "Es ist eine neuere Version der App verfügbar",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BLACK,
      textColor: WHITE,
      fontSize: 16.0,
    );
  }
}
