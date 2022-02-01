import 'package:Smarthome/pages/home.dart';
import 'package:Smarthome/pages/room_details.dart';
import 'package:flutter/material.dart';

class TabletWidthHomePage extends StatefulWidget {
  TabletWidthHomePage({Key? key}) : super(key: key);

  @override
  State<TabletWidthHomePage> createState() => _TabletWidthHomePageState();
}

class _TabletWidthHomePageState extends State<TabletWidthHomePage> {
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
            roomIdChanged: (id) => setState(() {
              this.roomID = id;
            }),
          ),
          width: width * 0.4,
          height: fullHeight,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Container(
            child: RoomDetailsPage(
              this.roomID,
              isOnBigScreen: true,
            ),
            width: width * 0.5,
            height: fullHeight,
          ),
        ),
      ],
    );
  }
}
