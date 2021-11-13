import 'package:Smarthome/dialogs/DialogWrapper.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      text: "Über Smarthome",
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: SizedBox(
            height: 75.0,
            child: Image.asset(
              "assets/images/icon_inverted.png",
            ),
          ),
        ),
        FutureBuilder(
          future: rootBundle.loadString("pubspec.yaml"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Version: ' +
                    loadYaml(
                      snapshot.data.toString(),
                    )["version"]
                        .toString()
                        .split("+")[0],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              );
            }
            return Container();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Copyright Ⓒ 2021 \nJan Bellenberg",
            style: TextStyle(fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Wetter via openweathermap.org",
            style: TextStyle(fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Made with",
              style: TextStyle(fontSize: 15.0),
            ),
            FlutterLogo(
              size: 80.0,
              style: FlutterLogoStyle.horizontal,
            )
          ],
        ),
      ],
    );
  }
}
