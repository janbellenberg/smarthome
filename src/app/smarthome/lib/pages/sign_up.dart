import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/widgets/heroStyleBuilder.dart';
import 'package:Smarthome/widgets/rounded_text_field.dart';
import 'package:Smarthome/widgets/wave_animation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                Hero(
                  flightShuttleBuilder: flightShuttleBuilder,
                  tag: "sign-up",
                  child: Text(
                    "Konto erstellen",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                RoundedTextField(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 20.0,
                    bottom: 10.0,
                  ),
                  labelText: "Vorname",
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.person_outline,
                ),
                RoundedTextField(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  labelText: "Nachname",
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.person_outline,
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
                ),
                TextButton(
                  onPressed: () => {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    child: Text("Konto erstellen",
                        style: TextStyle(fontSize: 20.0, color: WHITE)),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Zurück",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor)),
                ),
                Spacer(),
                WaveAnimation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
