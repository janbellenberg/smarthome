import 'package:flutter/material.dart';

enum DeviceType {
  LIGHT,
  HEATER,
  AC,
  KITCHEN,
  VIDEO,
  ROVER,
  CONTROLLER,
  INFRASTRUCTURE,
  EMBEDDED,
  ENDPOINT,
  SENSOR,
  ACTOR,
  OTHER,
}

const Map<DeviceType, String?> typeID = {
  DeviceType.LIGHT: "lgt",
  DeviceType.HEATER: 'htr',
  DeviceType.AC: 'ac',
  DeviceType.KITCHEN: 'kit',
  DeviceType.VIDEO: 'vid',
  DeviceType.ROVER: 'rvr',
  DeviceType.CONTROLLER: 'ctr',
  DeviceType.INFRASTRUCTURE: 'inf',
  DeviceType.EMBEDDED: 'emb',
  DeviceType.ENDPOINT: 'end',
  DeviceType.SENSOR: 'snr',
  DeviceType.ACTOR: 'acr',
  DeviceType.OTHER: null,
};

const Map<DeviceType?, IconData> deviceIcons = {
  DeviceType.LIGHT: Icons.lightbulb_outline,
  DeviceType.HEATER: Icons.thermostat,
  DeviceType.AC: Icons.ac_unit,
  DeviceType.KITCHEN: Icons.kitchen,
  DeviceType.VIDEO: Icons.videocam_outlined,
  DeviceType.ROVER: Icons.memory,
  DeviceType.CONTROLLER: Icons.build,
  DeviceType.INFRASTRUCTURE: Icons.device_hub,
  DeviceType.EMBEDDED: Icons.developer_board,
  DeviceType.ENDPOINT: Icons.desktop_windows,
  DeviceType.SENSOR: Icons.input,
  DeviceType.ACTOR: Icons.touch_app,
  DeviceType.OTHER: Icons.bubble_chart,
  null: Icons.signal_wifi_off
};
