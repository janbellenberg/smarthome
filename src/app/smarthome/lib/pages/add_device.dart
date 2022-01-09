import 'dart:typed_data';

import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
/*import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';*/

class AddDevicePage extends StatefulWidget {
  AddDevicePage({Key? key}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  int selectedBuilding = 1;

  /*@override
  initState() {
    super.initState();
    startNFC();
  }

  Future<void> startNFC() async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    if (isAvailable) {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          MifareClassic? nfc = MifareClassic.from(tag);

          if (nfc == null) {
            print('Tag is not compatible');
            return;
          }
          Uint8List key = Uint8List.fromList([
            0xFF,
            0xFF,
            0xFF,
            0xFF,
            0xFF,
            0xFF,
          ]);

          bool auth = await nfc.authenticateSectorWithKeyA(
            sectorIndex: 2,
            key: key,
          );
          try {
            if (auth) print(await nfc.readBlock(blockIndex: 8));
          } on PlatformException catch (_) {}
        },
      );
    }

    // Stop Session
    //NfcManager.instance.stopSession();
  }*/

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (var item in state.buildings)
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GestureDetector(
                          onTap: () => setState(() {
                            selectedBuilding = item.ID!;
                          }),
                          child: Text(
                            item.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: item.ID == selectedBuilding
                                    ? Theme.of(context).colorScheme.primary
                                    : GRAY),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              RoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        "assets/images/icons8_NFC_N_96px.png",
                        width: 70.0,
                      ),
                    ),
                    Text(
                      "Automatisch",
                      style: TextStyle(
                        fontSize: 33.0,
                      ),
                    ),
                    Text(
                      "Halten Sie jetzt den NFC-Tag an Ihr Gerät",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "- oder -",
                style: TextStyle(
                  fontSize: 21.0,
                ),
              ),
              GestureDetector(
                onTap: () {}, // TODO: implement route
                child: RoundedContainer(
                  padding: EdgeInsets.all(22.0),
                  child: Column(
                    children: [
                      Text(
                        "Manuelle Einrichtung",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
