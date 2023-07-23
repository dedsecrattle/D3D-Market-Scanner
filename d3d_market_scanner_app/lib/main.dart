import 'package:d3d_market_scanner_app/authentication/auth_page.dart';
import 'package:d3d_market_scanner_app/utils.dart';
import 'package:d3d_market_scanner_app/authentication/email_verify_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initData();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

bool isLoading = true;

Future initData() async {
  const url = "https://d3d-financial-data-api.onrender.com/init";
  var response = await http.get(Uri.parse(url));
  return response;
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
