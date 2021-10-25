import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/pages/building_edit.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class NoBuildingsWidget extends StatelessWidget {
  const NoBuildingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Icon(Icons.home, size: 100.0, color: ACCENT),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 30.0,
            ),
            child: Text(
              "Es sind keine Gebäude verfügbar",
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuildingEditPage(
                  new Building("Zuhause", "", "", "", "Deutschland"),
                ),
              ),
            ),
            child: RoundedContainer(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.add,
                      color: ACCENT,
                    ),
                  ),
                  Text(
                    "Gebäude hinzufügen",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
