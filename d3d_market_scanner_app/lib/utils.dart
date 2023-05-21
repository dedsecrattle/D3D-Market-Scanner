import 'package:flutter/material.dart';

class Utils {
  static final message = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) {
      return;
    }
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    message.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
