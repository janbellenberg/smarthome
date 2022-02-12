import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/services/api/base.dart';

dynamic getInfo() async {
  return await HTTP.fetch(GET_INFO);
}
