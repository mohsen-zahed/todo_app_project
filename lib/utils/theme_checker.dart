import 'package:flutter/material.dart';

class ThemeChecker {
  bool isThemeLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
}

final themeChecker = ThemeChecker();
