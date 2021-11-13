import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/core/page_wrapper.dart';
import 'package:Smarthome/pages/qr_scanner.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
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
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QrImage(
                          data: "test", // TODO: replace with invite string
                          version: 9,
                          size: 250.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: Text(
                            "- oder -",
                            style: TextStyle(fontSize: 19.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => PageWrapper.routeToPage(
                            QR_Scanner_Page(),
                            context,
                          ),
                          child: RoundedContainer(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: ACCENT,
                                ),
                                Text(
                                  "QR-Code scannen",
                                  style: TextStyle(fontSize: 19.0),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
