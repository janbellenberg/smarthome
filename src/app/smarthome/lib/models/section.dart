import 'property.dart';

class Section {
  String name = "";
  Map<String, String> informations = new Map();
  Map<String, String> details = new Map();
  Map<String, String> actions = new Map();
  List<Property> properties = new List.empty(growable: true);

  Section(Map<String, dynamic> data) {
    this.name = data["name"];

    if (data.containsKey("informations")) {
      data["informations"].forEach(
        (value) => this.informations[value["label"]] = value["value"],
      );
    }

    if (data.containsKey("details")) {
      data["details"].forEach(
        (value) => this.details[value["command"]] = value["label"],
      );
    }

    if (data.containsKey("properties")) {
      data["properties"].forEach(
        (value) => this.properties.add(
              new Property(value),
            ),
      );
    }

    if (data.containsKey("actions")) {
      data["actions"]
          .forEach((value) => this.actions[value["command"]] = value["label"]);
    }
  }
}
