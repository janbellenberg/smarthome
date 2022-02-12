import 'package:Smarthome/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'rounded_container.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(this.currentWeather, {Key? key}) : super(key: key);

  final String? currentWeather;

  getIcon() {
    switch (currentWeather) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '02d':
      case '02n':
        return WeatherIcons.day_cloudy;
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return WeatherIcons.cloud;
      case '13d':
      case '13n':
        return WeatherIcons.snow;
      case '11d':
      case '11n':
        return WeatherIcons.thunderstorm;
      case '10d':
      case '10n':
        return WeatherIcons.day_rain;
      case '09d':
      case '09n':
        return WeatherIcons.rain;
      case '50d':
      case '50n':
        return WeatherIcons.fog;
      case '01n':
        return WeatherIcons.stars;
      default:
        return null;
    }
  }

  getString() {
    switch (currentWeather) {
      case '01d':
        return "Sonne";
      case '02d':
      case '02n':
        return "Leicht\nbewölkt";
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return "Bewölkt";
      case '13d':
      case '13n':
        return "Schnee";
      case '11d':
      case '11n':
        return "Gewitter";
      case '10d':
      case '10n':
        return "Leichter\nRegen";
      case '09d':
      case '09n':
        return "Regen";
      case '50d':
      case '50n':
        return "Nebel";
      case '01n':
        return "Sterne";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (getString() == null || getIcon() == null) {
      return Container();
    }

    return RoundedContainer(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  getIcon(),
                  color: Theme.of(context).colorScheme.secondary,
                  size: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    getString(),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: Text("Powered by openweathermap.org",
                style: TextStyle(
                  fontSize: 11.0,
                  color: BLACK.withOpacity(0.4),
                )),
          )
        ],
      ),
    );
  }
}
