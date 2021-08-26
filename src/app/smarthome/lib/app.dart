import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/pages/add_device.dart';
import 'package:Smarthome/pages/home.dart';
import 'package:Smarthome/pages/quick_actions.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
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
          setState(() {
            switch (index) {
              case 0:
                setState(() {
                  currentPage = HomePage();
                });
                break;
              case 1:
                setState(() {
                  currentPage = AddDevicePage();
                });
                break;
              case 2:
                setState(() {
                  currentPage = QuickActionsPage();
                });
                break;
              default:
                setState(() {
                  currentPage = HomePage();
                });
                break;
            }
          });
        },
      ),
    );
  }
}
