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

  static Widget makeInput(
      {label, textController, isEmail = false, obsureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obsureText,
          controller: textController,
          keyboardType: isEmail ? TextInputType.emailAddress : null,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
