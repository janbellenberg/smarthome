import 'package:Smarthome/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvitePage extends StatefulWidget {
  InvitePage({Key? key}) : super(key: key);

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: WHITE,
                      size: 30.0,
                    ),
                  ),
                  Text(
                    "Person einladen",
                    style: TextStyle(color: WHITE, fontSize: 30.0),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QrImage(
                        data: "test",
                        version: 9,
                        size: 300.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
