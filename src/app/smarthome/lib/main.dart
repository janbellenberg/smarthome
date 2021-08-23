import 'package:Smarthome/themes/light.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'SmartHome', theme: LightTheme, home: App());
  }
}
