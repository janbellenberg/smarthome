import '../models/device.dart';
import 'web_widget.dart';
import 'package:flutter/material.dart';

import 'rounded_container.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(this.device, this.label, this.command, {Key? key})
      : super(key: key);

  final Device device;
  final String label;
  final String command;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebWidget(
            "https://" + this.device.local + this.command,
            this.device.name + ": " + this.label,
          ),
        ),
      ),
      child: RoundedContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              this.label,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
