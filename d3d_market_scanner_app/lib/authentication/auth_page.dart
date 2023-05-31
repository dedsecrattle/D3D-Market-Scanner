import 'package:d3d_market_scanner_app/authentication/login_view.dart';
import 'package:d3d_market_scanner_app/authentication/register_view.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? Login(onClickedSignup: toggle)
        : Register(onClickedSignIn: toggle);
  }

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
