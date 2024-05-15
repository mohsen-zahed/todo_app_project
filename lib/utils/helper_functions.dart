import 'package:flutter/material.dart';

class HelperFuncions {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

final HelperFuncions helperFuncions = HelperFuncions();
