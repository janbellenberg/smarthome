import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/pages/sign_up.dart';
import 'package:Smarthome/widgets/heroStyleBuilder.dart';
import 'package:Smarthome/widgets/rounded_text_field.dart';
import 'package:Smarthome/widgets/wave_animation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                Text(
                  "Login",
                  style: TextStyle(fontSize: 40.0),
                ),
                RoundedTextField(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    top: 40.0,
                    bottom: 20.0,
                  ),
                  labelText: "Kunden-ID",
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.person_outline,
                ),
                RoundedTextField(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    top: 10.0,
                    bottom: 40.0,
                  ),
                  labelText: "Passwort",
                  obscureText: true,
                  prefixIcon: Icons.password,
                ),
                TextButton(
                  onPressed: () => {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    child: Text("Anmelden",
                        style: TextStyle(fontSize: 20.0, color: WHITE)),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  ),
                  child: Hero(
                    flightShuttleBuilder: flightShuttleBuilder,
                    tag: "sign-up",
                    child: Text("Konto erstellen",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).colorScheme.primary)),
                  ),
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
