import 'package:Smarthome/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: WHITE,
                      size: 30.0,
                    ),
                  ),
                  Text(
                    "Über Smarthome",
                    style: TextStyle(color: WHITE, fontSize: 30.0),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(50.0),
                          padding: const EdgeInsets.only(
                            top: 40.0,
                            bottom: 40.0,
                            left: 50.0,
                            right: 50.0,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.28),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(500.0),
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/icon_inverted.png",
                            width: 100.0,
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
                              );
                            }
                            return Container();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Copyright Ⓒ Jan Bellenberg 2021",
                            style: TextStyle(fontSize: 15.0),
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
                              size: 150.0,
                              style: FlutterLogoStyle.horizontal,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
