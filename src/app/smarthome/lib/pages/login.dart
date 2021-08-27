import 'package:Smarthome/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, top: 40.0, bottom: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      labelText: 'Kunden-ID',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: Icon(Icons.person_outline,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, right: 50.0, top: 10.0, bottom: 40.0),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      labelText: 'Passwort',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: Icon(Icons.password,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () => {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                      ),
                      child: Text("Anmelden",
                          style: TextStyle(fontSize: 20.0, color: WHITE)),
                    )),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [
                          Theme.of(context).accentColor.withAlpha(175),
                          Theme.of(context).accentColor.withAlpha(175)
                        ],
                        [
                          Theme.of(context).accentColor,
                          Theme.of(context).accentColor
                        ],
                        [
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor
                        ],
                        [Theme.of(context).primaryColor, GRAY],
                      ],
                      durations: [35000, 20000, 15000, 20000],
                      heightPercentages: [0.20, 0.30, 0.40, 0.65],
                      gradientBegin: Alignment.bottomCenter,
                      gradientEnd: Alignment.topCenter,
                    ),
                    size: Size(
                      double.infinity,
                      200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
