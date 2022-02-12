import 'package:Smarthome/constants/api.dart';

import 'base.dart';

dynamic loadUserInfos() async {
  return await HTTP.fetch(GET_USER);
}
