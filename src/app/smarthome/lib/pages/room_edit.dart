import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/rooms.dart';
import 'package:Smarthome/models/room.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:Smarthome/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';

class RoomEditPage extends StatefulWidget {
  RoomEditPage(this.selectedRoom, {Key? key}) : super(key: key);
  final Room selectedRoom;

  @override
  _RoomEditPageState createState() => _RoomEditPageState(this.selectedRoom);
}

class _RoomEditPageState extends State<RoomEditPage> {
  _RoomEditPageState(this.selectedRoom) {
    this.add = selectedRoom.ID == null;
  }

  late bool add;
  late Room selectedRoom;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController.fromValue(
      TextEditingValue(text: this.selectedRoom.name),
    );
    print(add);
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
                      size: 30.0,
                    ),
                  ),
                  Text(
                    this.selectedRoom.name.trim() == ""
                        ? "Raum hinzufügen"
                        : this.selectedRoom.name,
                    style: TextStyle(color: WHITE, fontSize: 30.0),
                  ),
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
                        RoundedTextField(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                            top: 40.0,
                            bottom: 20.0,
                          ),
                          labelText: "Name",
                          controller: this.nameController,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (this.add) {
                              addRoom(
                                this.nameController.text,
                                this.selectedRoom.building,
                              ).then((value) => Navigator.pop(context));
                            } else {
                              updateRoom(
                                this.selectedRoom.ID ?? 0,
                                this.nameController.text,
                                this.selectedRoom.building,
                              ).then((value) => Navigator.pop(context));
                            }
                          },
                          child: RoundedContainer(
                            margin: EdgeInsets.only(
                              top: 25.0,
                              left: 50.0,
                              right: 50.0,
                            ),
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.save_alt,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      size: 30.0),
                                ),
                                Text(
                                  "Daten speichern",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ],
                            ),
                          ),
                        )
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
