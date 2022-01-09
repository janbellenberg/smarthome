import 'dart:ui';

import 'package:Smarthome/controller/device.dart';
import 'package:Smarthome/controller/rooms.dart';
import 'package:Smarthome/core/page_wrapper.dart';
import 'package:Smarthome/dialogs/ConfirmDelete.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/pages/room_edit.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants/colors.dart';
import '../models/device.dart';
import '../models/room.dart';
import '../widgets/device_item.dart';
import 'package:flutter/material.dart';

class RoomDetailsPage extends StatefulWidget {
  RoomDetailsPage(this.roomID, {Key? key}) : super(key: key);
  final int roomID;

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState(this.roomID);
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  _RoomDetailsPageState(this.roomID);
  int roomID;

  @override
  void initState() {
    super.initState();
    loadDevices(this.roomID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: RefreshIndicator(
        color: ACCENT,
        strokeWidth: 2.0,
        onRefresh: () async {
          await loadDevices(this.roomID);
        },
        child: StoreProvider(
          store: store,
          child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              Building selectedBuilding = state.buildings.firstWhere(
                (element) => element.ID == state.selectedBuilding,
                orElse: () => new Building.fromDB({}),
              );

              Room selectedRoom = selectedBuilding.rooms.firstWhere(
                (element) => element.ID == this.roomID,
                orElse: () => new Room.fromDB({}, state.selectedBuilding),
              );

              return Padding(
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
                          Text(
                            selectedRoom.name,
                            style: TextStyle(color: WHITE, fontSize: 25.0),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => {
                                  showModalBottomSheet(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    builder: (context) {
                                      return buildBottomSheet(selectedRoom);
                                    },
                                  )
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
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              children: [
                                for (Device device in selectedRoom.devices)
                                  DeviceItem(device: device)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  buildBottomSheet(Room selectedRoom) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        height: 200.0,
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30),
                topRight: const Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
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
                    padding: const EdgeInsets.only(bottom: 10.0),
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
                      onTap: () {
                        Navigator.pop(context);
                        PageWrapper.routeToPage(
                          RoomEditPage(
                            selectedRoom,
                          ),
                          context,
                        );
                      }),
                  ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: Text("Raum löschen"),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) => ConfirmDeleteDialog(
                          () {
                            Navigator.pop(context);
                            deleteRoom(
                              roomID,
                              selectedRoom.building,
                            );
                          },
                          "Möchten Sie den Raum löschen?",
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
