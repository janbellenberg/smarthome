import 'package:Smarthome/dialogs/DialogWrapper.dart';
import 'package:flutter/material.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      children: [
        Text(
          "Ihr Konto wurde erfolgreich angelegt.\nBitte überprüfen Sie Ihr E-Mail-Postfach, um Ihre Kundennummer herauszufinden.",
        )
      ],
    );
  }
}
