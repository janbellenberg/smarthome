import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'rounded_container.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(this.currentWeather, {Key? key}) : super(key: key);

  final String currentWeather;

  getIcon() {
    switch (currentWeather) {
      case 'sun':
        return WeatherIcons.day_sunny;
      case 'sun+cloudy':
        return WeatherIcons.day_cloudy;
      case 'cloudy':
        return WeatherIcons.cloud;
      case 'snow':
        return WeatherIcons.snow;
      case 'wind':
        return WeatherIcons.day_windy;
      case 'sun+rain':
        return WeatherIcons.day_rain;
      case 'rain':
        return WeatherIcons.rain;
      case 'fog':
        return WeatherIcons.fog;
      case 'stars':
        return WeatherIcons.stars;
      default:
    }
  }

  getString() {
    switch (currentWeather) {
      case 'sun':
        return "Sonne";
      case 'sun+cloudy':
        return "Wenige\nWolken";
      case 'cloudy':
        return "Wolken";
      case 'snow':
        return "Schnee";
      case 'wind':
        return "Wind";
      case 'sun+rain':
        return "Leichter\nRegen";
      case 'rain':
        return "Regen";
      case 'fog':
        return "Nebel";
      case 'stars':
        return "Sterne";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Text("Powered by api.com", style: TextStyle(fontSize: 11.5)),
          )
        ],
      ),
    );
  }
}
