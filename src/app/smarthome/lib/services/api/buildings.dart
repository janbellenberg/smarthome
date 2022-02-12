import 'package:Smarthome/constants/api.dart';

import 'base.dart';

dynamic loadBuildings() async {
  return await HTTP.fetch(GET_BUILDINGS);
}

dynamic addBuilding(
  String name,
  String street,
  String postcode,
  String city,
  String country,
) async {
  return await HTTP.fetch(ADD_BUILDING
    ..requestData = {
      "name": name,
      "street": street,
      "postcode": postcode,
      "city": city,
      "country": country,
    });
}

dynamic updateBuilding(
  int id,
  String name,
  String street,
  String postcode,
  String city,
  String country,
) async {
  return await HTTP.fetch(UPDATE_BUILDING
    ..requestData = {
      "name": name,
      "street": street,
      "postcode": postcode,
      "city": city,
      "country": country,
    }
    ..parameters.addAll({"id": id.toString()}));
}

dynamic deleteBuilding(int id) async {
  return await HTTP.fetch(DELETE_BUILDING
    ..parameters.addAll(
      {"id": id.toString()},
    ));
}

dynamic getJoinToken(int building) async {
  return await HTTP.fetch(
    GET_JOIN_TOKEN
      ..parameters.addAll(
        {"bid": building.toString()},
      ),
  );
}

dynamic joinBuilding(String token) async {
  return await HTTP.fetch(
    JOIN_BUILDING..requestString = token,
  );
}
