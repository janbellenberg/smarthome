import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    required this.labelText,
    this.padding,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.maxWidth = 900,
    Key? key,
  }) : super(key: key);

  final String labelText;
  final EdgeInsets? padding;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: this.maxWidth),
      child: Padding(
        padding: this.padding ?? EdgeInsets.all(0),
        child: TextField(
          controller: this.controller,
          obscureText: this.obscureText,
          keyboardType: this.keyboardType,
          enableSuggestions:
              !(obscureText || this.keyboardType != TextInputType.text),
          autocorrect:
              !(obscureText || this.keyboardType != TextInputType.text),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            labelText: this.labelText,
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon,
                    color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
