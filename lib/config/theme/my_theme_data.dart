import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/config/theme/custom_theme_data_props.dart';

class MyThemeData {
  static MyThemeData? _myThemeData;
  MyThemeData._();
  static MyThemeData get instance {
    _myThemeData ??= MyThemeData._();
    return _myThemeData!;
  }

  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: colors.lightPrimaryColor,
      scaffoldBackgroundColor: colors.lightScaffoldBackgroundColor,
      // primaryTextTheme: myPrimaryTextTheme.lightPrimaryTextTheme(context),
      textTheme: CustomThemeDataProps.instance.lightTextTheme(),
      appBarTheme: CustomThemeDataProps.instance.lightAppBarTheme(context),
      floatingActionButtonTheme: CustomThemeDataProps.instance.lightFloatingActionButtonThemeData(context),
    );
  }

  ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: colors.darkPrimaryColor,
      scaffoldBackgroundColor: colors.darkScaffoldBackgroundColor,
      // primaryTextTheme: myPrimaryTextTheme.darkPrimaryTextTheme(context),
      textTheme: CustomThemeDataProps.instance.darkTextTheme(),
      appBarTheme: CustomThemeDataProps.instance.darkAppBarTheme(context),
      floatingActionButtonTheme: CustomThemeDataProps.instance.darkFloatingActionButtonThemeData(context),
    );
  }
}
