import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    required this.labelText,
    this.padding,
    this.controller, // TODO: make required
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    Key? key,
  }) : super(key: key);

  final String labelText;
  final EdgeInsets? padding;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding ?? EdgeInsets.all(0),
      child: TextField(
        controller: this.controller,
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
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
