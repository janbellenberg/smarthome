import 'dart:ui';
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
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: new SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: const EdgeInsets.all(25.0),
        title: Text(
          "Bestätigung",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        children: [
          Text(
            "Möchten Sie das Gebäude löschen?",
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
      ),
    );
  }
}
