import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('MainUI'),
          leading: const SideMenuWidget(),
        ),
        body: Center(
            child: TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text('SignOut'))));
  }
}
