import 'package:d3d_market_scanner_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return const MainUI();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Your Email'),
        ),
      );
    }
  }
}
