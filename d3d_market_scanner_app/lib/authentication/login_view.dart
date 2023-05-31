import 'package:d3d_market_scanner_app/utils.dart';
import 'package:d3d_market_scanner_app/authentication/reset_password_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignup;

  const Login({Key? key, required this.onClickedSignup}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          title: const Text('Login'),
          backgroundColor: Colors.pink,
        ),
        resizeToAvoidBottomInset: false,
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
                  onPressed: () => {signIn()},
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ResetPassword())),
                child: const Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      text: 'No Account? ',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignup,
                        text: 'Register',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 15))
                  ]))
            ],
          ),
        ));
  }

  Future signIn() async {
    setState(() {
      animationType = 'hands_down';
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      setState(() {
        animationType = "success";
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        animationType = "fail";
      });
      Utils.showSnackBar(e.message);
    }
  }
}
