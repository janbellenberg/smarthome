import 'package:Smarthome/models/shortcut.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class QuickActionsPage extends StatefulWidget {
  QuickActionsPage({Key? key}) : super(key: key);

  @override
  _QuickActionsPageState createState() => _QuickActionsPageState();
}

class _QuickActionsPageState extends State<QuickActionsPage> {
  List<Shortcut> shortcuts = List<Shortcut>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    shortcuts.add(Shortcut.fromDB(1, 1, 1, "Wohnzimmer Deckenlampe", "/on"));
    shortcuts.add(Shortcut.fromDB(1, 1, 2, "Kaffee kochen", "/coffee"));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            for (var shortcut in this.shortcuts)
              RoundedContainer(
                margin: EdgeInsets.zero,
                width: 150.0,
                child: Text(
                  shortcut.description,
                  style: TextStyle(fontSize: 17.0),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}
