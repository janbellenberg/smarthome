import 'dart:ui';

import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  const DialogWrapper({
    this.text = "Smart Home",
    this.children,
    Key? key,
  }) : super(key: key);

  final String text;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: new SimpleDialog(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: const EdgeInsets.all(25.0),
        title: Text(
          this.text,
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        children: this.children,
      ),
    );
  }
}
