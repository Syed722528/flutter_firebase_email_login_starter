import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/pages/home_page.dart';
import 'package:flutter_firebase_email_login_starter/services/login_or_signup.dart';

// This widget is to make sure user doesn't have to login again after the app is closed

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAuth.instance.currentUser != null
          ? const HomePage() // Manually show HomePage if user is logged in
          : const LoginOrSignup(),
    );
  }
}
