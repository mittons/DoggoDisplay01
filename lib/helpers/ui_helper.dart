import 'package:flutter/material.dart';

class UiHelper {
  static void displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
