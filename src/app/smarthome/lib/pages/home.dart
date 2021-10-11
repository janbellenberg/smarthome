import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Building> buildings = List<Building>.empty(growable: true);
  List<Room> rooms = List<Room>.empty(growable: true);
  late String currentWeather;
  int selectedBuilding = 1;

  @override
  void initState() {
    super.initState();
    buildings.add(Building.fromDB(
        1, "Zuhause", "Fasanenstraße 40", "45134", "Essen", "Deutschland"));
    buildings.add(Building.fromDB(2, "Arbeit", "", "", "", ""));

    rooms.add(Room.fromDB(1, "Wohnzimmer", 1));
    rooms.add(Room.fromDB(2, "Schlafzimmer", 1));
    rooms.add(Room.fromDB(3, "Jan", 1));

    currentWeather = "sun+cloudy";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Building Selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (var item in buildings)
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
                              ? Theme.of(context).colorScheme.primary
                              : GRAY),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "+",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: GRAY, fontSize: 25.0),
                ),
              ),
            ],
          ),
        ),
        // Weather
        WeatherWidget(currentWeather),
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
                          fontWeight: FontWeight.bold, fontSize: 16.0),
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
                        builder: (context) =>
                            RoomEditPage(new Room("", this.selectedBuilding))),
                  ),
                  child: RoundedContainer(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    margin: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                    width: 175.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Raum\nhinzufügen",
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.left,
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InvitePage()),
                  ),
                  child: RoundedContainer(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    margin: const EdgeInsets.only(bottom: 50.0),
                    width: 175.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Einladen oder\nBeitreten",
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.left,
                        ),
                        Icon(Icons.person_add_alt),
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
                        this.buildings.firstWhere(
                            (element) => element.ID == this.selectedBuilding),
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
                    margin: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                    width: 175.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.edit_outlined),
                        Text(
                          "Gebäude\nbearbeiten",
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
                RoundedContainer(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  margin: const EdgeInsets.only(bottom: 50.0),
                  width: 175.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red),
                      Text(
                        "Gebäude\nlöschen",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
