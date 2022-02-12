import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/info.dart';
import 'package:Smarthome/core/page_wrapper.dart';
import 'package:Smarthome/services/shared_prefs/base.dart';
import 'package:Smarthome/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app.dart';
import 'redux/actions.dart' as redux;
import 'redux/store.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    readSessionID().then((value) {
      store.dispatch(
        new redux.Action(redux.ActionTypes.updateSessionID, payload: value),
      );

      if (value == null) {
        store.dispatch(
          new redux.Action(redux.ActionTypes.setupDone),
        );
      }
    });

    checkAppVersion();

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
      supportedLocales: [const Locale("de", "DE")],
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: PageWrapper(
        App(),
      ),
    );
  }
}
