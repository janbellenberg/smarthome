import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/pages/wait.dart';
import 'package:Smarthome/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app.dart';
import 'pages/login.dart';
import 'redux/store.dart';

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
      home: StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Stack(
              children: [
                state.sessionID != null ? App() : LoginPage(),
                if (state.waiting) WaitingPage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
