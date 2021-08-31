import '../models/property.dart';
import 'package:flutter/material.dart';

class SliderPropertyWidget extends StatefulWidget {
  SliderPropertyWidget(this.property, {Key? key}) : super(key: key);
  final Property property;

  @override
  _SliderPropertyWidgetState createState() =>
      _SliderPropertyWidgetState(this.property);
}

class _SliderPropertyWidgetState extends State<SliderPropertyWidget> {
  _SliderPropertyWidgetState(this.property) {
    if (property.moreInfo["min"].runtimeType == double) {
      this.min = property.moreInfo["min"];
    } else if (property.moreInfo["min"].runtimeType == int) {
      this.min = property.moreInfo["min"].toDouble();
    }

    if (property.moreInfo["max"].runtimeType == double) {
      this.max = property.moreInfo["max"];
    } else if (property.moreInfo["max"].runtimeType == int) {
      this.max = property.moreInfo["max"].toDouble();
    }

    if (property.moreInfo["divisions"] != null) {
      if (property.moreInfo["divisions"].runtimeType == int) {
        this.divisions = property.moreInfo["divisions"];
      }
    }
  }

  final Property property;
  double min = 0;
  double max = 100;
  int? divisions;

  @override
  Widget build(BuildContext context) {
    if (this.property.type == PropertyType.SLIDER &&
        this.property.value.runtimeType != double &&
        this.property.value.runtimeType != int) {
      return Container();
    } else if (this.property.type == PropertyType.RANGE &&
        this.property.value.runtimeType != RangeValues) {
      return Container();
    }

    return Row(
      children: [
        Text(
          this.property.label,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Expanded(
          child: this.property.type == PropertyType.SLIDER
              ? Slider(
                  onChanged: (value) {
                    setState(() {
                      this.property.value = value;
                    });
                  },
                  min: min,
                  max: max,
                  divisions: divisions,
                  label: '${(this.property.value * 100).round() / 100}',
                  value: this.property.value)
              : RangeSlider(
                  values: this.property.value,
                  onChanged: (value) {
                    setState(() {
                      this.property.value = value;
                    });
                  },
                  min: min,
                  max: max,
                  divisions: divisions,
                  labels: RangeLabels(
                    '${(this.property.value.start * 100).round() / 100}',
                    '${(this.property.value.end * 100).round() / 100}',
                  ),
                ),
        ),
        Text(divisions == null ? this.property.value.round().toString() : "")
      ],
    );
  }
}
