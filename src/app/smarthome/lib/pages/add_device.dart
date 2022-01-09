import 'dart:developer';
import 'dart:typed_data';

import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/device.dart';
import 'package:Smarthome/dialogs/SelectRoom.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/pages/qr_scanner.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Smarthome/core/page_wrapper.dart';

class AddDevicePage extends StatefulWidget {
  AddDevicePage({Key? key}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  PageWrapper.routeToPage(QR_Scanner_Page((scanData) {
                    showDialog(
                      context: context,
                      builder: (context) => SelectRoomDialog((roomID) {
                        addDevice(
                          scanData.code,
                          roomID,
                        );
                      }),
                    );
                  }), context);
                },
                child: RoundedContainer(
                  child: Text(
                    "QR-Code scannen\nund Raum auswählen",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.primary,
                height: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Anschließend:",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      "1. Gerät starten und Smartphone mit \"setup-wifi\" verbinden",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      "2. Gerät im Browser aufrufen und WLAN einrichten",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      "3. Gerät ist fertig eingerichtet",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
