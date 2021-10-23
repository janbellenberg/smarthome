import 'package:Smarthome/controller/buildings.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/services/api/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants/colors.dart';
import '../models/building.dart';
import '../models/room.dart';
import '../pages/room_details.dart';
import '../pages/room_edit.dart';
import '../widgets/heroStyleBuilder.dart';
import '../pages/invite.dart';
import '../widgets/rounded_container.dart';
import '../widgets/weather.dart';
import 'building_edit.dart';
import 'package:Smarthome/redux/actions.dart' as redux;
import 'package:Smarthome/redux/store.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Room> rooms = List<Room>.empty(growable: true);
  String? currentWeather;
  int selectedBuilding = 1;

  @override
  void initState() {
    super.initState();

    if (store.state.buildings.length < 1) {
      loadBuildings().then((_) => loadWeather());
    }

    rooms.add(Room.fromDB(1, "Wohnzimmer", 1));
    rooms.add(Room.fromDB(2, "Schlafzimmer", 1));
    rooms.add(Room.fromDB(3, "Jan", 1));
  }

  void loadWeather() {
    store.state.buildings.forEach((building) {
      if (building.weather != null) {
        return;
      }

      store.dispatch(new redux.Action(redux.ActionTypes.updateWaiting, true));
      fetchWeatherData(building.city, building.country).then((value) {
        setState(() {
          store.dispatch(
            new redux.Action(redux.ActionTypes.updateWeather, {
              "building": building.ID,
              "weather": value,
            }),
          );
        });

        store.dispatch(
          new redux.Action(redux.ActionTypes.updateWaiting, false),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double actionSize = MediaQuery.of(context).size.width / 2 - 25.0;

    // set active to first if deleted
    if (store.state.buildings.length > 0 &&
        store.state.buildings
                .where((element) => element.ID == this.selectedBuilding)
                .length <
            1) {
      setState(() {
        this.selectedBuilding = store.state.buildings[0].ID!;
      });
    }

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          loadWeather();
          return state.buildings.length < 1
              ? Container() // TODO: add first building
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
                                  selectedBuilding = item.ID!;
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
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BuildingEditPage(
                                  new Building("Test", "Musterstr. 40", "45134",
                                      "Berlin", "Deutschland"),
                                ),
                              ),
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
                        .firstWhere(
                            (element) => element.ID == this.selectedBuilding,
                            orElse: () => new Building("", "", "", "", ""))
                        .weather),
                    // Room selector
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        for (var item in rooms)
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoomDetailsPage(item)),
                            ),
                            child: RoundedContainer(
                              width: 150.0,
                              margin: const EdgeInsets.all(0),
                              child: Hero(
                                flightShuttleBuilder: flightShuttleBuilder,
                                tag: item.ID.toString(),
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoomEditPage(
                                        new Room("", this.selectedBuilding))),
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InvitePage()),
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuildingEditPage(
                                    state.buildings.firstWhere((element) =>
                                        element.ID == this.selectedBuilding),
                                  ),
                                ),
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
                              onTap: () =>
                                  deleteBuilding(this.selectedBuilding),
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
          .firstWhere((i) => i.ID == selectedBuilding,
              orElse: () => new Building("", "", "", "", ""))
          .weather;
    });
  }
}
