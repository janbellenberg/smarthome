import 'package:Smarthome/controller/device.dart';

import '../constants/colors.dart';
import '../constants/device_types.dart';
import '../models/device.dart';
import '../models/section.dart';
import '../widgets/section_widget.dart';
import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';

class DeviceDetailsPage extends StatefulWidget {
  DeviceDetailsPage(this.selectedDevice, {Key? key}) : super(key: key);
  final Device selectedDevice;

  @override
  State<DeviceDetailsPage> createState() =>
      _DeviceDetailsPageState(this.selectedDevice);
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  _DeviceDetailsPageState(this.selectedDevice);

  Device selectedDevice;

  @override
  void initState() {
    super.initState();
    getDeviceConfiguration(this.selectedDevice).then(
      (res) => setState(() {
        this.selectedDevice = res;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: RefreshIndicator(
          color: ACCENT,
          strokeWidth: 2.0,
          onRefresh: () async {
            getDeviceConfiguration(this.selectedDevice).then(
              (res) => setState(() {
                this.selectedDevice = res;
              }),
            );
          },
          child: EyeDrop(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
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
                          this.selectedDevice.name,
                          style: TextStyle(color: WHITE, fontSize: 30.0),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.delete_outline, color: WHITE),
                        )
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
                          padding:
                              const EdgeInsets.only(top: 30.0, bottom: 20.0),
                          child: Column(
                            children: [
                              Icon(
                                deviceIcons[this.selectedDevice.type],
                                color: Theme.of(context).colorScheme.secondary,
                                size: 150.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.0),
                                child: Text(
                                  this.selectedDevice.name,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                              Text("Hersteller: " + this.selectedDevice.vendor),
                              for (Section section
                                  in this.selectedDevice.sections)
                                SectionWidget(selectedDevice, section)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
