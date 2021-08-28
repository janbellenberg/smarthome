import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/models/room.dart';
import 'package:Smarthome/pages/room_details.dart';
import 'package:Smarthome/widgets/heroStyleBuilder.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:Smarthome/widgets/weather.dart';
import 'package:flutter/material.dart';

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

    buildings.add(Building.fromDB(1, "Zuhause", "", "", "", ""));
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
                              ? Theme.of(context).primaryColor
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
        // Add room
        RoundedContainer(
          child: Text(
            "Raum hinzufügen",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // invite
            RoundedContainer(
              margin: const EdgeInsets.only(bottom: 30.0),
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Person\neinladen",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                  Icon(Icons.person_add_alt),
                ],
              ),
            ),
            RoundedContainer(
              margin: const EdgeInsets.only(bottom: 30.0),
              width: 150.0,
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
    );
  }
}
