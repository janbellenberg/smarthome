import 'dart:ui';

import 'package:Smarthome/controller/device.dart';
import 'package:Smarthome/controller/rooms.dart';
import 'package:Smarthome/core/page_wrapper.dart';
import 'package:Smarthome/dialogs/ConfirmDelete.dart';
import 'package:Smarthome/models/app_state.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/pages/room_edit.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants/colors.dart';
import '../models/device.dart';
import '../models/room.dart';
import '../widgets/device_item.dart';
import 'package:flutter/material.dart';

class RoomDetailsPage extends StatefulWidget {
  RoomDetailsPage(this.roomID, {this.isOnBigScreen = false, Key? key})
      : super(key: key);
  int? roomID;
  final bool isOnBigScreen;

  @override
  State<RoomDetailsPage> createState() =>
      _RoomDetailsPageState(this.roomID, isOnBigScreen: this.isOnBigScreen);
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  _RoomDetailsPageState(this.roomID, {this.isOnBigScreen = false});
  int? roomID;
  final bool isOnBigScreen;

  @override
  void initState() {
    super.initState();
    if (this.roomID != null) {
      loadDevices(this.roomID!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        // reload rooms if changes on big platform
        if (this.roomID != state.selectedRoom && state.selectedRoom != null) {
          this.roomID = state.selectedRoom;
          loadDevices(this.roomID!);
        }

        if (this.roomID == null) {
          return Center(
            child: Text(
              "Bitte wählen Sie einen Raum aus.",
              style: TextStyle(
                color: ACCENT,
                fontSize: 25.0,
              ),
            ),
          );
        }

        Building selectedBuilding = state.buildings.firstWhere(
          (element) => element.ID == state.selectedBuilding,
          orElse: () => new Building.fromDB({}),
        );

        Room selectedRoom = selectedBuilding.rooms.firstWhere(
          (element) => element.ID == this.roomID,
          orElse: () => new Room.fromDB({}, state.selectedBuilding),
        );

        if (this.isOnBigScreen) {
          return Column(
            children: [
              for (Device device in selectedRoom.devices)
                DeviceItem(device: device)
            ],
          );
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: RefreshIndicator(
              color: ACCENT,
              strokeWidth: 2.0,
              onRefresh: () async {
                await loadDevices(this.roomID!);
              },
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
                                    return buildBottomSheet(
                                      selectedRoom,
                                      context,
                                    );
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
            ),
          );
        }
      },
    );
  }

  buildBottomSheet(Room selectedRoom, BuildContext context) {
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
                              this.roomID!,
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
