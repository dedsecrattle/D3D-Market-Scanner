import 'package:d3d_market_scanner_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  String animationType = 'idle';
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          animationType = 'hands_up';
        });
      } else {
        setState(() {
          animationType = 'hands_down';
        });
      }
    });

    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        setState(() {
          animationType = 'test';
        });
      } else {
        setState(() {
          animationType = 'idle';
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.pink,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: 300,
                child: FlareActor(
                  'assets/Teddy.flr',
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  animation: animationType,
                  callback: (animation) {
                    setState(() {
                      animationType = 'idle';
                    });
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(20),
                      ),
                      focusNode: emailFocusNode,
                      controller: emailController,
                    ),
                    const Divider(),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        contentPadding: EdgeInsets.all(20),
                      ),
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => {signUp()},
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future signUp() async {
    setState(() {
      animationType = 'hands_down';
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      setState(() {
        animationType = 'success';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        animationType = 'fail';
      });
      Utils.showSnackBar(e.message);
    }
  }
}
