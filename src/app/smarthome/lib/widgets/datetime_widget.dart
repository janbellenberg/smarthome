import 'package:Smarthome/controller/device.dart';

import '../models/property.dart';
import 'package:flutter/material.dart';

import 'rounded_container.dart';

class DateTimePropertyWidget extends StatefulWidget {
  DateTimePropertyWidget(
    this.property,
    this.deviceID, {
    Key? key,
  }) : super(key: key);
  
  final int deviceID;
  final Property property;

  @override
  _DateTimePropertyWidgetState createState() => _DateTimePropertyWidgetState(
        this.property,
        this.deviceID,
      );
}

class _DateTimePropertyWidgetState extends State<DateTimePropertyWidget> {
  _DateTimePropertyWidgetState(this.property, this.deviceID);

  final int deviceID;
  final Property property;

  @override
  Widget build(BuildContext context) {
    if (this.property.value.runtimeType != DateTime) {
      return Container();
    }

    return GestureDetector(
      onTap: () => this.property.type == PropertyType.DATE
          ? showDatePicker(
              context: context,
              initialDate: this.property.value,
              firstDate: DateTime(0),
              lastDate: DateTime(2100),
            ).then(
              (value) => setState(
                () {
                  this.property.value = value;
                },
              ),
            )
          : showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(this.property.value),
            ).then((value) {
              sendCommand(
                  this.property.identifier +
                      ":" +
                      this.property.value.day.toString() +
                      ":" +
                      this.property.value.month.toString() +
                      ":" +
                      this.property.value.year.toString() +
                      ":" +
                      this.property.value.hour.toString() +
                      ":" +
                      this.property.value.minute.toString(),
                  deviceID);
              setState(
                () {
                  this.property.value = value;
                },
              );
            }),
      child: RoundedContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 15.0,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              this.property.label,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            this.property.type == PropertyType.DATE
                ? Text(
                    this.property.value.day.toString().padLeft(2, "0") +
                        "." +
                        this.property.value.month.toString().padLeft(2, "0") +
                        "." +
                        this.property.value.year.toString().padLeft(2, "0"),
                  )
                : Text(
                    this.property.value.hour.toString().padLeft(2, "0") +
                        ":" +
                        this.property.value.minute.toString().padLeft(2, "0"),
                  )
          ],
        ),
      ),
    );
  }
}
