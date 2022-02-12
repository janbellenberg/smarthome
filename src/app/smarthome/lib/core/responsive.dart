import 'package:Smarthome/constants/screen_types.dart';
import 'package:flutter/material.dart';

ScreenType getScreenType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  Orientation orientation = MediaQuery.of(context).orientation;

  if (width < 500 || orientation == Orientation.portrait) {
    return ScreenType.SMARTPHONE;
  } else if (width < 1200) {
    return ScreenType.TABLET;
  } else {
    return ScreenType.DESKTOP;
  }
}
