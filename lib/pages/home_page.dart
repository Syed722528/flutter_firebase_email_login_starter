import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/services/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService firebaseAuth = AuthService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('Home Page'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Center(
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              iconColor: Colors.white,
              shape: RoundedRectangleBorder(),
              animationDuration: Duration(seconds: 3),
              shadowColor: Colors.grey,
              enableFeedback: true,
              elevation: 5,
            ),
            onPressed: () {
              firebaseAuth.logout();
              Navigator.pushNamed(context, '/auth');
            },
            label: Text('Log out'),
            icon: Icon(Icons.logout)),
      ),
    );
  }
}
