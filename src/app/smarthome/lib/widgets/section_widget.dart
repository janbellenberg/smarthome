import '../models/device.dart';
import '../models/property.dart';
import '../models/section.dart';
import 'package:flutter/material.dart';

import 'action_widget.dart';
import 'datetime_widget.dart';
import 'details_widget.dart';
import 'check_widget.dart';
import 'color_widget.dart';
import 'information_widget.dart';
import 'input_widget.dart';
import 'slider_widget.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget(this.device, this.section, {Key? key}) : super(key: key);

  final Device device;
  final Section section;

  @override
  Widget build(BuildContext context) {
    Column c = Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  this.section.name,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    this.section.informations.forEach((label, value) {
      c.children.add(
        InformationWidget(label, value),
      );
    });

    this.section.properties.forEach((property) {
      switch (property.type) {
        case PropertyType.TEXT:
        case PropertyType.NUMBER:
          c.children.add(InputPropertyWidget(property, device.ID ?? 0));
          break;
        case PropertyType.SLIDER:
        case PropertyType.RANGE:
          c.children.add(SliderPropertyWidget(property, device.ID ?? 0));
          break;
        case PropertyType.CHECK:
          c.children.add(CheckPropertyWidget(property, device.ID ?? 0));
          break;
        case PropertyType.COLOR:
          c.children.add(ColorPropertyWidget(property, device.ID ?? 0));
          break;
        case PropertyType.TIME:
        case PropertyType.DATE:
          c.children.add(DateTimePropertyWidget(property, device.ID ?? 0));
          break;
      }
    });

    this.section.actions.forEach((command, label) {
      c.children.add(
        ActionWidget(label, command, device.ID ?? 0),
      );
    });

    this.section.details.forEach((command, label) {
      c.children.add(
        DetailsWidget(this.device, label, command),
      );
    });

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: c,
    );
  }
}
