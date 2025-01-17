import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/services/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService firebaseAuth = AuthService();

    return Scaffold(appBar: AppBar(actions: [IconButton(onPressed: (){
firebaseAuth.logout();
Navigator.pushNamed(context, '/loginOrSignup');
    }, icon: Icon(Icons.login_outlined))],),);
  }
}