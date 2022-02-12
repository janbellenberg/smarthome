import 'package:flutter/material.dart';

class Property {
  late String identifier;
  String label = "";
  dynamic value;
  PropertyType type = PropertyType.TEXT;
  Map<String, dynamic> moreInfo = new Map();

  Property(Map<String, dynamic> data) {
    this.identifier = data["id"];
    this.label = data["label"];
    this.value = data["value"];

    if (data.containsKey("moreInfo")) {
      this.moreInfo = data["moreInfo"];
    }

    switch (data["type"]) {
      case 0:
        this.type = PropertyType.TEXT;
        break;
      case 1:
        this.type = PropertyType.NUMBER;
        break;
      case 2:
        this.type = PropertyType.SLIDER;
        break;
      case 3:
        this.type = PropertyType.RANGE;
        this.value = RangeValues(
          data["value"][0].toDouble(),
          data["value"][1].toDouble(),
        );
        break;
      case 4:
        this.type = PropertyType.CHECK;
        break;
      case 5:
        this.type = PropertyType.COLOR;
        this.value = Color.fromARGB(
          255,
          data["value"][0],
          data["value"][1],
          data["value"][2],
        );
        break;
      case 6:
        this.type = PropertyType.TIME;
        this.value = DateTime.parse(
          "0000-01-01 " + data["value"] + ":00",
        );
        break;
      case 7:
        this.type = PropertyType.DATE;
        this.value = DateTime.parse(data["value"]);
        break;
    }
  }
}

enum PropertyType { TEXT, NUMBER, SLIDER, RANGE, CHECK, COLOR, TIME, DATE }
