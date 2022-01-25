import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/models/device.dart';
import 'package:Smarthome/models/section.dart';
import 'package:Smarthome/services/api/devices.dart' as service;
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> loadDevices(int room) async {
  List<dynamic>? result = await runApiService(
    () => service.loadDevices(room),
  );

  if (result == null) {
    return;
  }

  store.dispatch(
    new Action(ActionTypes.clearDevices, payload: {
      "building": store.state.selectedBuilding,
      "room": room,
    }),
  );

  result.forEach((element) {
    store.dispatch(new Action(
      ActionTypes.addDevice,
      payload: {
        "data": Device.fromDB(element),
        "building": store.state.selectedBuilding,
        "room": room,
      },
    ));
  });
}

Future<String?> sendCommand(String command, int deviceID) async {
  String? result = await runApiService(
    () => service.sendCommand(command, deviceID),
    isString: true,
  );

  if (result != null) {
    if (result.trim().length < 1) {
      return null;
    }

    String status = result.substring(0, 1);

    if (result.trim().length < 2 && status == "+") {
      return result;
    }

    String text = result.substring(1, result.length);

    if (status != "0") {
      Fluttertoast.showToast(
        msg: status == "+"
            ? text
            : "Das Gerät konnte diese Aktion nicht umsetzen",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: BLACK,
        textColor: WHITE,
        fontSize: 16.0,
      );
    }
  }

  return result!;
}

Future<Device> getDeviceConfiguration(Device device) async {
  Map<String, dynamic>? result = await runApiService(
    () => service.getDeviceConfiguration(device.ID ?? 0),
  );

  if (result == null) {
    return device;
  }

  for (dynamic section in result["sections"]) {
    device.sections.add(new Section(section));
  }

  return device;
}

Future<void> addDevice(
  final String mac,
  final int roomID,
) async {
  await runApiService(
    () => service.addDevice(mac, roomID),
  );
}
