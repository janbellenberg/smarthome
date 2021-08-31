import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/pages/wait.dart';
import 'package:Smarthome/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'pages/login.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  final bool isLoggedIn = true;
  final bool isWaiting = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: ACCENT,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: ACCENT,
          systemNavigationBarIconBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: ACCENT,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: BLACK,
          systemNavigationBarIconBrightness: Brightness.light));
    }

    return MaterialApp(
      title: 'SmartHome',
      theme: LightTheme,
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          this.isLoggedIn ? App() : LoginPage(),
          if (isWaiting) WaitingPage(),
        ],
      ),
    );
  }
}
