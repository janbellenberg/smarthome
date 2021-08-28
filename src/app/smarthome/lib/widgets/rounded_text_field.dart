import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    required this.labelText,
    required this.padding,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    Key? key,
  }) : super(key: key);

  final String labelText;
  final EdgeInsets padding;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: TextField(
        obscureText: this.obscureText,
        keyboardType: this.keyboardType,
        enableSuggestions:
            !(obscureText || this.keyboardType != TextInputType.text),
        autocorrect: !(obscureText || this.keyboardType != TextInputType.text),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          labelText: this.labelText,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          prefixIcon: Icon(prefixIcon, color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
