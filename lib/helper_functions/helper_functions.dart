import 'package:flutter/material.dart';

class HelperFunctions {
  static HelperFunctions? _helperFunctions;
  HelperFunctions._();
  static HelperFunctions get instance {
    _helperFunctions ??= HelperFunctions._();
    return _helperFunctions!;
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
