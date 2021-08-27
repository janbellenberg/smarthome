import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/constants/device_types.dart';
import 'package:Smarthome/models/device.dart';
import 'package:Smarthome/models/room.dart';
import 'package:Smarthome/widgets/device_item.dart';
import 'package:Smarthome/widgets/heroStyleBuilder.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
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
        1, "Deckenlampe", DeviceType.LIGHT, "", "", "mac", "local", 1,
        status: "Eingeschaltet"));
    this.devices.add(Device.fromDB(
        2, "Netzwerk", DeviceType.INFRASTRUCTURE, "", "", "mac", "local", 1,
        status: "Eingeschaltet"));
    this.devices.add(Device.fromDB(
        3, "Fernseher", DeviceType.VIDEO, "", "", "mac", "local", 1,
        status: "Eingeschaltet"));
    this.devices.add(Device.fromDB(
        4, "Licht Fenster", DeviceType.LIGHT, "", "", "mac", "local", 1,
        status: "Ausgeschaltet"));
    this
        .devices
        .add(Device.fromDB(5, "Ring-Kamera", null, "", "", "mac", "local", 1));
  }

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
                  Hero(
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: Text(this.selectedRoom.name,
                          style: TextStyle(color: WHITE, fontSize: 30.0)),
                      tag: this.selectedRoom.ID.toString())
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.60),
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
