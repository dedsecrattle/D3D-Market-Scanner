import 'package:d3d_market_scanner_app/authentication/auth_page.dart';
import 'package:d3d_market_scanner_app/home.dart';
import 'package:d3d_market_scanner_app/utils.dart';
import 'package:d3d_market_scanner_app/authentication/email_verify_view.dart';
import 'package:d3d_market_scanner_app/authentication/login_view.dart';
import 'package:d3d_market_scanner_app/authentication/reset_password_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'D3D Market Scanner',
    debugShowCheckedModeBanner: false,
    scaffoldMessengerKey: Utils.message,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const MyHome(),
  ));
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmail();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}
