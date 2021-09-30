import 'package:Smarthome/constants/colors.dart';
import 'package:flutter/material.dart';

final LightTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: BLACK,
    primaryVariant: BLACK,
    secondary: ACCENT,
    secondaryVariant: ACCENT,
    surface: Color(0xFF808080),
    background: WHITE,
    error: Colors.redAccent,
    onPrimary: BLACK,
    onSecondary: ACCENT,
    onSurface: Color(0xFF808080),
    onBackground: WHITE,
    onError: Colors.redAccent,
    brightness: Brightness.light,
  ),
  fontFamily: 'Raleway',
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: BLACK,
    selectionColor: ACCENT,
    selectionHandleColor: BLACK,
  ),
);
