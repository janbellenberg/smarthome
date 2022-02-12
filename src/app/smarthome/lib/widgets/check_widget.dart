import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/device.dart';

import '../models/property.dart';
import 'rounded_container.dart';
import 'package:flutter/material.dart';

class CheckPropertyWidget extends StatefulWidget {
  CheckPropertyWidget(this.property, this.deviceID, {Key? key})
      : super(key: key);
  final int deviceID;
  final Property property;

  @override
  _CheckPropertyWidgetState createState() =>
      _CheckPropertyWidgetState(this.property, this.deviceID);
}

class _CheckPropertyWidgetState extends State<CheckPropertyWidget> {
  _CheckPropertyWidgetState(this.property, this.deviceID);

  final int deviceID;
  final Property property;

  @override
  Widget build(BuildContext context) {
    if (property.value.runtimeType != bool) {
      return Container();
    }

    return RoundedContainer(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      color: this.property.value ? null : Colors.red.withOpacity(0.4),
      child: SwitchListTile(
        activeColor: ACCENT,
        inactiveThumbColor: BLACK.withAlpha((0.8 * 200).toInt()),
        onChanged: (value) async {
          String? result = await sendCommand(
            this.property.identifier + ":" + value.toString(),
            deviceID,
          );

          if (result != null && result.substring(0, 1) != "-") {
            setState(() {
              this.property.value = value;
            });
          }
        },
        value: property.value,
        title: Text(
          this.property.label,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
