import 'package:flutter/material.dart';

class HelperFunctions {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

final HelperFunctions helperFunctions = HelperFunctions();
