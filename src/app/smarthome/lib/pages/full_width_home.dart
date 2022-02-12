import 'package:Smarthome/pages/home.dart';
import 'package:Smarthome/pages/room_details.dart';
import 'package:Smarthome/pages/shortcuts.dart';
import 'package:flutter/material.dart';

class FullWidthHomePage extends StatefulWidget {
  FullWidthHomePage({Key? key}) : super(key: key);

  @override
  State<FullWidthHomePage> createState() => _FullWidthHomePageState();
}

class _FullWidthHomePageState extends State<FullWidthHomePage> {
  int? roomID;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height - 150;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: HomePage(
            isOnBigScreen: true,
          ),
          width: width * 0.3,
          height: fullHeight,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Container(
            child: RoomDetailsPage(
              this.roomID,
              isOnBigScreen: true,
            ),
            width: width * 0.4,
            height: fullHeight,
          ),
        ),
        Container(
          child: ShortcutsPage(),
          width: width * 0.2,
          height: fullHeight,
        ),
      ],
    );
  }
}
