import 'package:Smarthome/controller/device.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/models/shortcut.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ShortcutsPage extends StatefulWidget {
  ShortcutsPage({Key? key}) : super(key: key);

  @override
  _ShortcutsPageState createState() => _ShortcutsPageState();
}

class _ShortcutsPageState extends State<ShortcutsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        Building building = state.buildings.firstWhere(
          (element) => element.ID == state.selectedBuilding,
          orElse: () => new Building.fromDB({}),
        );

        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 20.0,
              runSpacing: 20.0,
              children: state.buildings.length < 1
                  ? []
                  : [
                      for (Shortcut shortcut in building.shortcuts)
                        GestureDetector(
                          onTap: () {
                            sendCommand(shortcut.command, shortcut.device);
                          },
                          child: RoundedContainer(
                            margin: EdgeInsets.zero,
                            width: 150.0,
                            child: Text(
                              shortcut.description,
                              style: TextStyle(fontSize: 17.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
            ),
          ),
        );
      },
    );
  }
}
