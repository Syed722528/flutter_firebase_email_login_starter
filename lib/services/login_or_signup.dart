import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/pages/login_page.dart';
import 'package:flutter_firebase_email_login_starter/pages/signup_page.dart';
import 'package:flutter_firebase_email_login_starter/utils/constants.dart';
import 'package:flutter_firebase_email_login_starter/widgets/button_group.dart';


class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool _isLoginPage = false;

  void togglePage() {
    setState(() {
      _isLoginPage = !_isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAnimatedBackground(),
    );
  }

  AnimateGradient buildAnimatedBackground() {
    return AnimateGradient(
        primaryColors: primaryColors,
        secondaryColors: secondaryColors,
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        textDirectionForGeometry: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            children: [
              ButtonGroup(
                  isLoginSelected: _isLoginPage,
                  onLoginPressed: () {
                    setState(() {
                      _isLoginPage = true;
                    });
                  },
                  onSignUpPressed: () {
                    setState(() {
                      _isLoginPage = false;
                    });
                  }),
              _isLoginPage
                  ? LoginPage(onPressed: togglePage)
                  : SignupPage(onPressed: togglePage)
            ],
          ),
        ));
  }
}
