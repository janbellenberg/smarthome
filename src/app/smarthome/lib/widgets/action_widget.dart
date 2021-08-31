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
          horizontal: 30.0,
          vertical: 20.0,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Row(
          children: [
            Icon(Icons.send),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
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
