import 'package:Smarthome/themes/light.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'pages/login.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: LightTheme,
      home: this.isLoggedIn ? App() : LoginPage(),
    );
  }
}
