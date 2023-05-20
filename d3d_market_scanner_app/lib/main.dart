import 'package:d3d_market_scanner_app/views/email_verify_view.dart';
import 'package:d3d_market_scanner_app/views/login_view.dart';
import 'package:d3d_market_scanner_app/views/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const EmailVerifyView(),
  ));
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Home',
        textAlign: TextAlign.center,
      )),
    );
  }
}
