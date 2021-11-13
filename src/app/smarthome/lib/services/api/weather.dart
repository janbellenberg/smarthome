import 'dart:convert';
import 'dart:developer';
import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:http/http.dart';

dynamic loadWeather(String city, String country) async {
  try {
    Uri url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?q=${city},${country}&appid=${WEATHER_API_KEY}',
    );

    Response res = await get(url);
    return res.statusCode == 200
        ? json.decoder.convert(res.body)
        : HTTPError.UNKNOWN;
  } catch (e) {
    if (IS_DEBUGGING) {
      log(e.toString());
    }
    return HTTPError.CONNECTION_ERROR;
  }
}
