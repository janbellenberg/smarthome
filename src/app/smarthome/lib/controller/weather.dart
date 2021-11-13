import 'package:Smarthome/constants/countries.dart';
import 'package:Smarthome/controller/base.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/redux/actions.dart' as redux;
import 'package:Smarthome/services/api/weather.dart' as service;

Future<void> loadWeather() async {
  for (Building building in store.state.buildings) {
    if (building.weather != null) {
      return;
    }

    String country = countryCodes[building.country] ?? "";

    Map<String, dynamic>? result = await runApiService(
      () => service.loadWeather(building.city, country),
    );

    if (result == null) {
      return;
    }

    store.dispatch(
      new redux.Action(redux.ActionTypes.updateWeather, payload: {
        "building": building.ID,
        "weather": result["weather"][0]["icon"],
      }),
    );
  }
}
