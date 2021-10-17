import '../constants/colors.dart';
import '../constants/device_types.dart';
import '../models/device.dart';
import '../models/room.dart';
import '../widgets/device_item.dart';
import '../widgets/heroStyleBuilder.dart';
import 'package:flutter/material.dart';

class RoomDetailsPage extends StatefulWidget {
  RoomDetailsPage(this.selectedRoom, {Key? key}) : super(key: key);
  final Room selectedRoom;

  @override
  _RoomDetailsPageState createState() =>
      _RoomDetailsPageState(this.selectedRoom);
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  _RoomDetailsPageState(this.selectedRoom);
  Room selectedRoom;
  List<Device> devices = List<Device>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    this.devices.add(Device.fromDB(
          1,
          "Deckenlampe",
          DeviceType.LIGHT,
          "",
          "Jan Bellenberg",
          "mac",
          "local",
          1,
          status: "Eingeschaltet",
        ));
    this.devices.add(Device.fromDB(
          2,
          "Netzwerk",
          DeviceType.INFRASTRUCTURE,
          "",
          "",
          "mac",
          "local",
          1,
          status: "Eingeschaltet",
        ));
    this.devices.add(Device.fromDB(
          3,
          "Fernseher",
          DeviceType.VIDEO,
          "",
          "",
          "mac",
          "local",
          1,
          status: "Eingeschaltet",
        ));
    this.devices.add(Device.fromDB(
          4,
          "Licht Fenster",
          DeviceType.LIGHT,
          "",
          "",
          "mac",
          "local",
          1,
          status: "Ausgeschaltet",
        ));
    this.devices.add(Device.fromDB(
          5,
          "Ring-Kamera",
          null,
          "",
          "",
          "mac",
          "local",
          1,
        ));
  }

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
                      size: 25.0,
                    ),
                  ),
                  Hero(
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: Text(
                      this.selectedRoom.name,
                      style: TextStyle(color: WHITE, fontSize: 25.0),
                    ),
                    tag: this.selectedRoom.ID.toString(),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 200.0,
                                  color: Color(0xff737373),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: WHITE,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(30),
                                        topRight: const Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 15.0,
                                        right: 15.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Text(
                                              "Aktionen",
                                              style: TextStyle(
                                                fontSize: 25.5,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.edit,
                                              color: ACCENT,
                                            ),
                                            title: Text("Raum bearbeiten"),
                                            onTap: () => {},
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                            title: Text("Raum löschen"),
                                            onTap: () => {},
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: WHITE,
                          size: 30.0,
                        ),
                      ),
                    ],
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
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        for (var device in this.devices)
                          DeviceItem(device: device)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
