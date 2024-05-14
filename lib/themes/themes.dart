import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';

class Themes {
  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: colors.lightPrimaryColor,
      scaffoldBackgroundColor: colors.lightScaffoldBackgroundColor,
    );
  }

  ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: colors.darkPrimaryColor,
      scaffoldBackgroundColor: colors.darkScaffoldBackgroundColor,
    );
  }
}

final themes = Themes();
