import 'package:Smarthome/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text("SmartHome"),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        height: 60,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.home_outlined, size: 30, color: WHITE),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add_box_outlined, size: 30, color: WHITE),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.list_alt, size: 30, color: WHITE),
          ),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}
