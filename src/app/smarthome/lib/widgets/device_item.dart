import 'package:Smarthome/core/page_wrapper.dart';

import '../pages/device_details.dart';
import 'package:flutter/material.dart';
import '../constants/device_types.dart';
import '../models/device.dart';
import 'rounded_container.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PageWrapper.routeToPage(
        DeviceDetailsPage(this.device),
        context,
      ),
      onDoubleTap: () => {}, // TODO: default action
      child: RoundedContainer(
          margin: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                deviceIcons[device.type],
                color: Theme.of(context).colorScheme.secondary,
                size: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      device.online ? "Eingeschaltet" : "Offline",
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
