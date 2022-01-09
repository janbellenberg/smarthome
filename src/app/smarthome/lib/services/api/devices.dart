import 'package:Smarthome/constants/api.dart';

import 'base.dart';

dynamic loadDevices(int room) async {
  return await HTTP.fetch(GET_DEVICES
    ..parameters = {
      "room": room.toString(),
    });
}

dynamic sendCommand() async {}

dynamic addDevice(
  final String mac,
  final int roomID,
) async {
  return await HTTP.fetch(
    ADD_DEVICE
      ..requestData = {
        "room": roomID,
        "mac": mac,
      },
  );
}
