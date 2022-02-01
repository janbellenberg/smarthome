import 'package:Smarthome/controller/buildings.dart';
import 'package:Smarthome/controller/weather.dart';
import 'package:Smarthome/core/page_wrapper.dart';
import 'package:Smarthome/dialogs/ConfirmDelete.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/redux/actions.dart' as redux;
import 'package:Smarthome/widgets/no_buildings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants/colors.dart';
import '../models/building.dart';
import '../models/room.dart';
import '../pages/room_details.dart';
import '../pages/room_edit.dart';
import '../pages/invite.dart';
import '../widgets/rounded_container.dart';
import '../widgets/weather.dart';
import 'building_edit.dart';
import 'package:Smarthome/redux/store.dart';

class HomePage extends StatefulWidget {
  HomePage({this.roomIdChanged, this.isOnBigScreen = false, Key? key})
      : super(key: key);
  final bool isOnBigScreen;
  final Function(int)? roomIdChanged;

  @override
  _HomePageState createState() => _HomePageState(
        isOnBigScreen: this.isOnBigScreen,
        roomIdChanged: this.roomIdChanged,
      );
}

class _HomePageState extends State<HomePage> {
  _HomePageState({this.roomIdChanged, this.isOnBigScreen = false});
  String? currentWeather;
  bool isOnBigScreen;
  Function(int)? roomIdChanged;

  @override
  Widget build(BuildContext context) {
    int selectedBuilding = store.state.selectedBuilding;
    double actionSize =
        MediaQuery.of(context).size.width / (this.isOnBigScreen ? 10 : 2) -
            25.0;

    // set active to first if deleted
    if (store.state.buildings.length > 0 &&
        store.state.buildings
                .where((element) => element.ID == selectedBuilding)
                .length <
            1) {
      setState(() {
        selectedBuilding = store.state.buildings[0].ID!;
      });
    }

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          loadWeather();
          selectedBuilding = state.selectedBuilding;
          return state.buildings.length < 1
              ? NoBuildingsWidget()
              : Column(
                  children: [
                    // Building Selector
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          for (var item in state.buildings)
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  store.dispatch(
                                    new redux.Action(
                                      redux.ActionTypes.updateSelectedBuilding,
                                      payload: item.ID!,
                                    ),
                                  );
                                }),
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: item.ID == selectedBuilding
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : GRAY),
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () => PageWrapper.routeToPage(
                              BuildingEditPage(
                                new Building("", "", "", "", "Deutschland"),
                              ),
                              context,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: GRAY,
                                    fontSize: 25.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Weather
                    WeatherWidget(state.buildings
                        .firstWhere((element) => element.ID == selectedBuilding,
                            orElse: () => new Building.fromDB({}))
                        .weather),
                    // Room selector
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        for (var item in state.buildings
                            .firstWhere(
                              (element) => element.ID == selectedBuilding,
                              orElse: () => new Building.fromDB({}),
                            )
                            .rooms)
                          GestureDetector(
                            onTap: () {
                              if (MediaQuery.of(context).size.width < 700) {
                                PageWrapper.routeToPage(
                                  RoomDetailsPage(item.ID ?? 0),
                                  context,
                                );
                              } else {
                                if (this.roomIdChanged != null)
                                  this.roomIdChanged!(item.ID!);
                              }
                            },
                            child: RoundedContainer(
                              width: 150.0,
                              margin: const EdgeInsets.all(0),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // invite
                        Column(
                          children: [
                            // Add room
                            GestureDetector(
                              onTap: () => PageWrapper.routeToPage(
                                RoomEditPage(
                                  new Room("", selectedBuilding),
                                ),
                                context,
                              ),
                              child: RoundedContainer(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                margin: const EdgeInsets.only(
                                    top: 20.0, bottom: 15.0),
                                width: actionSize,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Raum\nhinzufügen",
                                      style: TextStyle(fontSize: 15.0),
                                      textAlign: TextAlign.left,
                                    ),
                                    Icon(Icons.add, color: ACCENT),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => PageWrapper.routeToPage(
                                InvitePage(selectedBuilding),
                                context,
                              ),
                              child: RoundedContainer(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                margin: const EdgeInsets.only(bottom: 50.0),
                                width: actionSize,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Einladen /\nBeitreten",
                                      style: TextStyle(fontSize: 15.0),
                                      textAlign: TextAlign.left,
                                    ),
                                    Icon(Icons.person_add_alt, color: ACCENT),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => PageWrapper.routeToPage(
                                BuildingEditPage(
                                  state.buildings.firstWhere(
                                    (element) => element.ID == selectedBuilding,
                                  ),
                                ),
                                context,
                              ),
                              child: RoundedContainer(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                margin: const EdgeInsets.only(
                                    top: 20.0, bottom: 15.0),
                                width: actionSize,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.edit_outlined, color: ACCENT),
                                    Text(
                                      "Gebäude\nbearbeiten",
                                      style: TextStyle(fontSize: 15.0),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                barrierColor: Colors.transparent,
                                builder: (context) => ConfirmDeleteDialog(
                                  () => deleteBuilding(selectedBuilding),
                                  "Möchten Sie das Gebäude löschen?",
                                ),
                              ),
                              child: RoundedContainer(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                margin: const EdgeInsets.only(bottom: 50.0),
                                width: actionSize,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.delete_outline,
                                        color: Colors.red),
                                    Text(
                                      "Gebäude\nlöschen",
                                      style: TextStyle(fontSize: 15.0),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
        });
  }

  void updateWeather() {
    setState(() {
      this.currentWeather = store.state.buildings
          .firstWhere((i) => i.ID == store.state.selectedBuilding,
              orElse: () => new Building("", "", "", "", ""))
          .weather;
    });
  }
}
