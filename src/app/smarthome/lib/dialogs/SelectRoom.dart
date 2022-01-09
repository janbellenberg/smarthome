import 'package:Smarthome/dialogs/DialogWrapper.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/models/room.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:flutter/material.dart';

class SelectRoomDialog extends StatelessWidget {
  const SelectRoomDialog(
    this.action, {
    Key? key,
  }) : super(key: key);
  final Function(int id) action;

  @override
  Widget build(BuildContext context) {
    int selectedBuilding = store.state.selectedBuilding;
    List<Room> rooms = store.state.buildings
        .firstWhere(
          (element) => element.ID == selectedBuilding,
          orElse: () => new Building.fromDB({}),
        )
        .rooms;

    return DialogWrapper(
      text: "Raum auswählen",
      children: [
        for (Room r in rooms)
          GestureDetector(
            onTap: () {
              action(r.ID!);
              Navigator.pop(context);
            },
            child: Text(r.name),
          )
      ],
    );
  }
}
