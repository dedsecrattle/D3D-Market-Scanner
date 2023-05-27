import 'package:d3d_market_scanner_app/utils.dart';
import 'package:d3d_market_scanner_app/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
              return const MainUI();
            } else {
              return const Login();
            }
          }),
    );
  }
}

class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('MainUI')),
        body: Center(
            child: TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text('SignOut'))));
  }
}
