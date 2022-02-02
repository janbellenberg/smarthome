import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/constants/screen_types.dart';
import 'package:Smarthome/controller/shortcuts.dart';
import 'package:Smarthome/controller/users.dart';
import 'package:Smarthome/core/responsive.dart';
import 'package:Smarthome/dialogs/Info.dart';
import 'package:Smarthome/pages/add_device.dart';
import 'package:Smarthome/pages/full_width_home.dart';
import 'package:Smarthome/pages/home.dart';
import 'package:Smarthome/pages/shortcuts.dart';
import 'package:Smarthome/redux/actions.dart' as redux;
import 'package:Smarthome/redux/store.dart';
import 'package:Smarthome/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'controller/auth.dart';
import 'controller/buildings.dart';
import 'controller/rooms.dart';
import 'controller/weather.dart';
import 'models/app_state.dart';
import 'pages/tablet_width_home.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late int currentPage = 0;

  @override
  void initState() {
    super.initState();
    this.reloadData();
  }

  @override
  Widget build(BuildContext context) {
    // build the welcome string for the top

    int currentHour = DateTime.now().hour;
    String titleString = "";
    if (currentHour <= 10) {
      titleString = "Guten Morgen";
    } else if (currentHour <= 18) {
      titleString = "Guten Tag";
    } else {
      titleString = "Guten Abend";
    }

    String seperator =
        getScreenType(context) == ScreenType.SMARTPHONE ? ",\n" : ", ";

    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          String greeting = titleString;
          if (state.username != null) {
            greeting += seperator;
            greeting += state.username!;
          }

          return Container(
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              children: [
                Container(
                  height: getScreenType(context) == ScreenType.SMARTPHONE
                      ? 100.0
                      : 75.0,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          greeting,
                          style: TextStyle(
                              color: WHITE,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        // IconButtons
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: IconButton(
                                onPressed: () => showDialog(
                                      barrierColor: Colors.transparent,
                                      context: context,
                                      builder: (context) => InfoDialog(),
                                    ),
                                icon: Icon(
                                  Icons.info_outline,
                                  color: WHITE,
                                  size: 30.0,
                                )),
                          ),
                          IconButton(
                            onPressed: logout,
                            icon: Icon(
                              Icons.logout,
                              color: WHITE,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // BODY
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: RefreshIndicator(
                      color: ACCENT,
                      strokeWidth: 2.0,
                      onRefresh: () async {
                        store.dispatch(
                          new redux.Action(redux.ActionTypes.clearBuildings),
                        );
                        this.reloadData();
                      },
                      child: Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                switch (getScreenType(context)) {
                                  case ScreenType.TABLET:
                                    return TabletWidthHomePage();
                                  case ScreenType.DESKTOP:
                                    return FullWidthHomePage();
                                  default:
                                    return this.getSelectedPage();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: getScreenType(context) == ScreenType.SMARTPHONE
          ? Navigation(
              currentIndex: this.currentPage,
              onSelectedChanged: (i) => setState(() {
                this.currentPage = i;
              }),
            )
          : null,
    );
  }

  void reloadData() {
    loadUsername();
    if (store.state.buildings.length < 1) {
      loadBuildings().then((_) {
        loadWeather();
        store.state.buildings.forEach((building) {
          if (building.ID != null) {
            loadRooms(building.ID!);
            loadShortcuts(building.ID!);
          }
        });
      });
    }
  }

  Widget getSelectedPage() {
    switch (this.currentPage) {
      case 0:
        return HomePage();
      case 1:
        return AddDevicePage();
      case 2:
        return ShortcutsPage();
      default:
        return HomePage();
    }
  }
}
