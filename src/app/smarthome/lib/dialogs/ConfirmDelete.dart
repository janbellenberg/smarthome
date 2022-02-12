import 'package:Smarthome/dialogs/DialogWrapper.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog(
    this.action,
    this.message, {
    Key? key,
  }) : super(key: key);
  final Function() action;
  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      text: "Bestätigung",
      children: [
        Text(
          this.message,
          style: TextStyle(fontSize: 15.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                this.action();
                Navigator.pop(context);
              },
              child: Text("Ja"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    "Nein",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
