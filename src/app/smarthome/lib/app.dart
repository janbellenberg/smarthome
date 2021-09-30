import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/pages/add_device.dart';
import 'package:Smarthome/pages/home.dart';
import 'package:Smarthome/pages/quick_actions.dart';
import 'package:Smarthome/widgets/navigation.dart';
import 'package:flutter/material.dart';

import 'pages/info.dart';

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
    // build the welcome string for the top
    String titleString = ", Jan!";
    int currentHour = DateTime.now().hour;

    if (currentHour <= 10) {
      titleString = "Guten Morgen" + titleString;
    } else if (currentHour <= 18) {
      titleString = "Guten Tag" + titleString;
    } else {
      titleString = "Guten Abend" + titleString;
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            Container(
              height: 125.0,
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        titleString,
                        style: TextStyle(
                            color: WHITE,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      // IconButtons
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: IconButton(
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoPage()),
                                  ),
                              icon: Icon(
                                Icons.info_outline,
                                color: WHITE,
                                size: 30.0,
                              )),
                        ),
                        IconButton(
                            onPressed: () => {}, // TODO: implement Route
                            icon: Icon(
                              Icons.logout,
                              color: WHITE,
                              size: 30.0,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // BODY
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: currentPage,
                    ))))
          ],
        ),
      ),
      bottomNavigationBar: Navigation(
        onSelectedChanged: changeSelectedPage,
      ),
    );
  }

  void changeSelectedPage(int index) {
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
  }
}
