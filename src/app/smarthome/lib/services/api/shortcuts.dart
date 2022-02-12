import 'package:Smarthome/constants/api.dart';

import 'base.dart';

dynamic loadShortcuts(int building) async {
  return await HTTP.fetch(GET_SHORTCUTS
    ..parameters.addAll(
      {"bid": building.toString()},
    ));
}
