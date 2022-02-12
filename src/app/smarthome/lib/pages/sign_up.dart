import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/controller/auth.dart';
import 'package:Smarthome/dialogs/SignUpDialog.dart';
import 'package:Smarthome/widgets/rounded_text_field.dart';
import 'package:Smarthome/widgets/wave_animation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 25.0),
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Konto erstellen",
                style: TextStyle(fontSize: 40.0),
              ),
              RoundedTextField(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  top: 20.0,
                  bottom: 10.0,
                ),
                labelText: "Vorname",
                prefixIcon: Icons.person_outline,
                controller: this.firstName,
              ),
              RoundedTextField(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                labelText: "Nachname",
                prefixIcon: Icons.person_outline,
                controller: this.lastName,
              ),
              RoundedTextField(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                labelText: "E-Mail",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail_outline,
                controller: this.email,
              ),
              RoundedTextField(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  top: 10.0,
                  bottom: 30.0,
                ),
                labelText: "Passwort",
                obscureText: true,
                prefixIcon: Icons.password,
                controller: this.password,
              ),
              TextButton(
                onPressed: () => signUp(
                  this.firstName.text,
                  this.lastName.text,
                  this.email.text,
                  this.password.text,
                ).then((success) {
                  if (success) {
                    showDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) => SignUpDialog(),
                    );
                  }
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  child: Text(
                    "Konto erstellen",
                    style: TextStyle(fontSize: 20.0, color: WHITE),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
