import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/services/api/buildings.dart' as service;

Future<void> loadBuildings() async {
  List<dynamic>? result = await performApiOperation(
    () => service.loadBuildings(),
  );

  if (result == null) {
    return;
  }

  store.dispatch(new Action(ActionTypes.clearBuildings, null));
  result.forEach((data) {
    store.dispatch(new Action(
      ActionTypes.addBuilding,
      new Building.fromDB(data),
    ));
  });
}

Future<void> addBuilding(String name, String street, String postcode,
    String city, String country) async {
  await performApiOperation(
    () => service.addBuilding(name, street, postcode, city, country),
  );

  await loadBuildings();
}

Future<void> updateBuilding(int id, String name, String street, String postcode,
    String city, String country) async {
  await performApiOperation(
    () => service.updateBuilding(id, name, street, postcode, city, country),
  );

  await loadBuildings();
}

Future<void> deleteBuilding(int id) async {
  await performApiOperation(
    () => service.deleteBuilding(id),
  );

  await loadBuildings();
}
