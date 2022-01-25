import 'package:Smarthome/constants/api.dart';

import 'base.dart';

dynamic loadDevices(int room) async {
  return await HTTP.fetch(GET_DEVICES
    ..parameters = {
      "room": room.toString(),
    });
}

dynamic sendCommand(String cmd, int deviceID) async {
  return await HTTP.fetch(
    SEND_CMD
      ..requestString = cmd
      ..parameters = {
        "id": deviceID.toString(),
      },
  );
}

dynamic getDeviceConfiguration(int device) async {
  return await HTTP.fetch(GET_DEVICE_CONFIG
    ..parameters = {
      "id": device.toString(),
    });
}

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
