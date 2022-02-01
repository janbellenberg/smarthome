import 'package:Smarthome/dialogs/DialogWrapper.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/pages/login.dart';
import 'package:Smarthome/pages/offline.dart';
import 'package:Smarthome/pages/wait.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper(this.page, {Key? key, this.overrideLogin = false})
      : super(key: key);

  static void routeToPage(
    Widget page,
    BuildContext context, {
    bool overrideLogin = true,
  }) {
    if (MediaQuery.of(context).size.width < 700) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageWrapper(page, overrideLogin: overrideLogin),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => DialogWrapper(
          isSubPage: true,
          children: [
            Container(
              child: page,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.45,
              ),
            )
          ],
        ),
      );
    }
  }

  final Widget page;
  final bool overrideLogin;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Stack(
            children: [
              state.sessionID != null || overrideLogin ? page : LoginPage(),
              if (state.runningTasks > 0 || !state.setupDone) WaitingPage(),
              if (!state.serverAvailable) OfflinePage(),
            ],
          );
        },
      ),
    );
  }
}
