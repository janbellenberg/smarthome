import 'package:Smarthome/constants/colors.dart';

import 'rounded_container.dart';
import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget(this.label, this.command, {Key? key}) : super(key: key);

  final String label;
  final String command;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {}, // TODO: send command
      child: RoundedContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 15.0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Row(
          children: [
            Icon(
              Icons.bolt,
              color: ACCENT,
              size: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                this.label,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
