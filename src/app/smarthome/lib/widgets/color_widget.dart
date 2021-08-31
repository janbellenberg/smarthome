import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';

import '../models/property.dart';
import 'rounded_container.dart';

class ColorPropertyWidget extends StatefulWidget {
  ColorPropertyWidget(this.property, {Key? key}) : super(key: key);
  final Property property;

  @override
  _ColorPropertyWidgetState createState() =>
      _ColorPropertyWidgetState(this.property);
}

class _ColorPropertyWidgetState extends State<ColorPropertyWidget> {
  _ColorPropertyWidgetState(this.property);
  final Property property;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 15.0,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.property.label,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          ColorButton(
            darkMode: true,
            color: this.property.value,
            boxShape: BoxShape.rectangle,
            size: 32,
            config: ColorPickerConfig(
              enableOpacity: false,
              enableLibrary: false,
            ),
            onColorChanged: (value) => setState(
              () => this.property.value = value,
            ),
          ),
        ],
      ),
    );
  }
}
