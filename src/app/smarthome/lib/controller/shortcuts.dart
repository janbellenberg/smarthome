import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/models/shortcut.dart';
import 'package:Smarthome/services/api/shortcuts.dart' as service;
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';

Future<void> loadShortcuts(int building) async {
  List<dynamic>? result = await runApiService(
    () => service.loadShortcuts(building),
  );

  if (result == null) {
    return;
  }

  store.dispatch(new Action(ActionTypes.clearShortcuts, payload: building));

  result.forEach((element) {
    store.dispatch(new Action(
      ActionTypes.addShortcut,
      payload: new Shortcut.fromDB(element, building),
    ));
  });
}
