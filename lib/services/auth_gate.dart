// import 'package:auth/pages/home_page.dart';
// import 'package:auth/services/login_or_signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthGate extends StatefulWidget {
//   const AuthGate({super.key});

//   @override
//   State<AuthGate> createState() => _AuthGateState();
// }

// class _AuthGateState extends State<AuthGate> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FirebaseAuth.instance.currentUser != null
//           ? const HomePage()
//           : LoginOrSignup(),
//     );
//   }
// }