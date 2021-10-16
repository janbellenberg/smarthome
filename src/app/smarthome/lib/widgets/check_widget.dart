import 'package:Smarthome/constants/colors.dart';

import '../models/property.dart';
import 'rounded_container.dart';
import 'package:flutter/material.dart';

class CheckPropertyWidget extends StatefulWidget {
  CheckPropertyWidget(this.property, {Key? key}) : super(key: key);
  final Property property;

  @override
  _CheckPropertyWidgetState createState() =>
      _CheckPropertyWidgetState(this.property);
}

class _CheckPropertyWidgetState extends State<CheckPropertyWidget> {
  _CheckPropertyWidgetState(this.property);

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
      gradient: this.property.value
          ? null
          : LinearGradient(
              colors: [
                Colors.red.withOpacity(0.5),
                Colors.red.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
      child: SwitchListTile(
        activeColor: ACCENT,
        inactiveThumbColor: BLACK.withAlpha((0.8 * 200).toInt()),
        onChanged: (value) {
          setState(() {
            this.property.value = value;
          });
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
