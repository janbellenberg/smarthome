import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/constants/countries.dart';
import 'package:Smarthome/controller/buildings.dart';
import 'package:Smarthome/models/building.dart';
import 'package:Smarthome/widgets/rounded_container.dart';
import 'package:Smarthome/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';

class BuildingEditPage extends StatefulWidget {
  BuildingEditPage(this.selectedBuilding, {Key? key}) : super(key: key);
  final Building selectedBuilding;

  @override
  _BuildingEditPageState createState() =>
      _BuildingEditPageState(this.selectedBuilding);
}

class _BuildingEditPageState extends State<BuildingEditPage> {
  _BuildingEditPageState(this.selectedBuilding) {
    add = this.selectedBuilding.ID == null;
  }

  late bool add;
  final Building selectedBuilding;
  late TextEditingController nameController;
  late TextEditingController streetController;
  late TextEditingController postcodeController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController.fromValue(
      TextEditingValue(text: this.selectedBuilding.name),
    );

    streetController = TextEditingController.fromValue(
      TextEditingValue(text: this.selectedBuilding.street),
    );

    postcodeController = TextEditingController.fromValue(
      TextEditingValue(text: this.selectedBuilding.postcode),
    );

    cityController = TextEditingController.fromValue(
      TextEditingValue(text: this.selectedBuilding.city),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: WHITE,
                    size: 30.0,
                  ),
                ),
                Text(
                  this.add
                      ? "Gebäude hinzufügen"
                      : this.selectedBuilding.name,
                  style: TextStyle(color: WHITE, fontSize: 24.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 40.0,
                    right: 40.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundedTextField(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        labelText: "Name",
                        controller: this.nameController,
                      ),
                      RoundedTextField(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        labelText: "Straße & Hausnr.",
                        controller: this.streetController,
                      ),
                      RoundedTextField(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        labelText: "PLZ",
                        controller: this.postcodeController,
                        keyboardType: TextInputType.number,
                      ),
                      RoundedTextField(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        labelText: "Stadt",
                        controller: this.cityController,
                      ),
                      Text(
                        "Land:",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Center(
                        child: DropdownButton(
                          items: countries
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          value: this.selectedBuilding.country,
                          onChanged: (String? newValue) {
                            setState(() {
                              this.selectedBuilding.country = newValue!;
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (add) {
                            addBuilding(
                              this.nameController.text,
                              this.streetController.text,
                              this.postcodeController.text,
                              this.cityController.text,
                              this.selectedBuilding.country,
                            ).then((value) => Navigator.pop(context));
                          } else {
                            updateBuilding(
                              this.selectedBuilding.ID!,
                              this.nameController.text,
                              this.streetController.text,
                              this.postcodeController.text,
                              this.cityController.text,
                              this.selectedBuilding.country,
                            ).then((value) => Navigator.pop(context));
                          }
                        },
                        child: RoundedContainer(
                          margin: EdgeInsets.only(
                            top: 25.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Icon(
                                  Icons.save_alt,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 30.0,
                                ),
                              ),
                              Text(
                                "Daten speichern",
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
