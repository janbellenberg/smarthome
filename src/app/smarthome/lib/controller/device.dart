import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/models/device.dart';
import 'package:Smarthome/services/api/devices.dart' as service;
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';

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

Future<dynamic> sendCommand() async {}

Future<void> addDevice(
  final String mac,
  final int roomID,
) async {
  await runApiService(
    () => service.addDevice(mac, roomID),
  );
}
