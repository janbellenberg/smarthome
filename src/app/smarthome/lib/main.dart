import 'dart:developer';

import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/pages/offline.dart';
import 'package:Smarthome/pages/wait.dart';
import 'package:Smarthome/services/shared_prefs/base.dart';
import 'package:Smarthome/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app.dart';
import 'pages/login.dart';
import 'redux/actions.dart' as redux;
import 'redux/store.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    readSessionID().then((value) {
      log(value ?? "");
      store.dispatch(
        new redux.Action(redux.ActionTypes.updateSessionID, value),
      );
    });

    if (store.state.sessionID != null) {
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
                if (!state.serverAvailable) OfflinePage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
