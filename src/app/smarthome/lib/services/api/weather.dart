import 'dart:convert';
import 'dart:developer';
import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:Smarthome/constants/countries.dart';
import 'package:http/http.dart';

Future<String> fetchWeatherData(String city, String country) async {
  try {
    country = countryCodes[country] ?? "";

    if (country == "") {
      return "";
    }

    var url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?q=${city},${country}&appid=${WEATHER_API_KEY}',
    );
    Response res = await get(url);
    return res.statusCode != 200
        ? ""
        : json.decoder.convert(res.body)["weather"][0]["icon"];
  } catch (e) {
    if (IS_DEBUGGING) {
      log(e.toString());
    }
    return "";
  }
}
