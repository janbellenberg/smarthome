import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> readSessionID() async {
  EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
  String sid = await prefs.getString("sessionID");
  return sid == "" ? null : sid;
}

void saveSessionID(String? sessionID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("sessionID");
}
