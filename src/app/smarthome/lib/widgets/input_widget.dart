import '../models/property.dart';
import 'rounded_text_field.dart';
import 'package:flutter/material.dart';

class InputPropertyWidget extends StatefulWidget {
  InputPropertyWidget(this.property, {Key? key}) : super(key: key);

  final Property property;

  @override
  _InputPropertyWidgetState createState() =>
      _InputPropertyWidgetState(this.property);
}

class _InputPropertyWidgetState extends State<InputPropertyWidget> {
  _InputPropertyWidgetState(this.property) {
    controller = TextEditingController.fromValue(
      TextEditingValue(
        text: this.property.value.toString(),
      ),
    );

    controller.addListener(() {
      // TODO: send data to device
    });
  }

  Property property;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    if (this.property.value.runtimeType != String &&
        this.property.value.runtimeType != double &&
        this.property.value.runtimeType != int) {
      return Container();
    }

    return RoundedTextField(
      controller: this.controller,
      labelText: this.property.label,
      keyboardType: this.property.value.runtimeType == String
          ? TextInputType.text
          : TextInputType.number,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
    );
  }
}
