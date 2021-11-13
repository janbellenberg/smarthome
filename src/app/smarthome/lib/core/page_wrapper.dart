import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/pages/login.dart';
import 'package:Smarthome/pages/offline.dart';
import 'package:Smarthome/pages/wait.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper(this.page, {Key? key}) : super(key: key);

  static void routeToPage(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageWrapper(page),
      ),
    );
  }

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Stack(
            children: [
              state.sessionID != null ? page : LoginPage(),
              if (state.runningTasks > 0 || !state.setupDone) WaitingPage(),
              if (!state.serverAvailable) OfflinePage(),
            ],
          );
        },
      ),
    );
  }
}