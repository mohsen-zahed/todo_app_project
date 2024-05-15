import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: colors.lightPrimaryColor,
    scaffoldBackgroundColor: colors.lightScaffoldBackgroundColor,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        color: colors.blackColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.lightPrimaryColor,
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: colors.whiteColor),
      iconTheme: IconThemeData(
        color: colors.whiteColor,
      ),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: colors.darkPrimaryColor,
    scaffoldBackgroundColor: colors.darkScaffoldBackgroundColor,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        color: colors.whiteColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.darkPrimaryColor,
      iconTheme: IconThemeData(
        color: colors.whiteColor,
      ),
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: colors.whiteColor),
    ),
  );
}
