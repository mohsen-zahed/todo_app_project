import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';


class CustomThemeDataProps {
  static CustomThemeDataProps? _customThemeDataProps;
  CustomThemeDataProps._();
  static CustomThemeDataProps get instance {
    // 1- if(_customThemeDataProps == null){
    // _customThemeDataProps = CustomThemeDataProps._();
    // }
    // or
    // 2- _customThemeDataProps ??= CustomThemeDataProps._();
    _customThemeDataProps ??= CustomThemeDataProps._();
    return _customThemeDataProps!;
  }

  //* Light TextTheme...
  TextTheme lightTextTheme() {
    return TextTheme(
      headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: colors.blackColor),
      headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: colors.blackColor),
      headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: colors.blackColor),
      //
      titleLarge: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: colors.blackColor),
      titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: colors.blackColor),
      titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: colors.blackColor),
      //
      bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: colors.blackColor),
      bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: colors.blackColor),
      bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: colors.blackColor.withOpacity(0.5)),
      //
      labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: colors.blackColor),
      labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: colors.blackColor.withOpacity(0.8)),
      labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: colors.blackColor.withOpacity(0.5)),
    );
  }

  //* Dark TextTheme...
  TextTheme darkTextTheme() {
    return TextTheme(
      headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: colors.whiteColor),
      headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: colors.whiteColor),
      headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: colors.whiteColor),
      //
      titleLarge: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, color: colors.whiteColor),
      titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: colors.whiteColor),
      titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: colors.whiteColor),
      //
      bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: colors.whiteColor),
      bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: colors.whiteColor),
      bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: colors.whiteColor.withOpacity(0.5)),
      //
      labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: colors.whiteColor),
      labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: colors.whiteColor.withOpacity(0.8)),
      labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: colors.whiteColor.withOpacity(0.5)),
    );
  }

  //! Light PrimayTextTheme...
  TextTheme lightPrimaryTextTheme(BuildContext context) {
    return TextTheme(
      titleLarge: TextStyle(
        color: colors.blackColor,
      ),
    );
  }

  //! Dark PrimayTextTheme...
  TextTheme darkPrimaryTextTheme(BuildContext context) {
    return TextTheme(
      titleLarge: TextStyle(
        color: colors.whiteColor,
      ),
    );
  }

  //* Light FloatingActionButtonThemeData...
  FloatingActionButtonThemeData lightFloatingActionButtonThemeData(BuildContext context) {
    return FloatingActionButtonThemeData(
      backgroundColor: colors.lightPrimaryColor,
      extendedTextStyle: Theme.of(context).textTheme.titleMedium,
      foregroundColor: colors.whiteColor,
    );
  }

  //* Dark FloatingActionButtonThemeData...
  FloatingActionButtonThemeData darkFloatingActionButtonThemeData(BuildContext context) {
    return FloatingActionButtonThemeData(
      backgroundColor: colors.lightPrimaryColor,
      extendedTextStyle: Theme.of(context).textTheme.titleMedium,
      foregroundColor: colors.whiteColor,
    );
  }

  //! Light AppBarTheme...
  AppBarTheme lightAppBarTheme(BuildContext context) {
    return AppBarTheme(
      backgroundColor: colors.lightPrimaryColor,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: colors.whiteColor),
      iconTheme: IconThemeData(
        color: colors.whiteColor,
      ),
    );
  }

  //! Dark AppBarTheme...
  AppBarTheme darkAppBarTheme(BuildContext context) {
    return AppBarTheme(
      backgroundColor: colors.darkPrimaryColor,
      iconTheme: IconThemeData(
        color: colors.whiteColor,
      ),
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: colors.whiteColor),
    );
  }
}
