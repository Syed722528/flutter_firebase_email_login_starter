import 'package:firebase_core/firebase_core.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/firebase_options.dart';
import 'package:flutter_firebase_email_login_starter/pages/home_page.dart';
import 'package:flutter_firebase_email_login_starter/services/login_or_signup.dart';

import 'services/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexify(
      designHeight: 912,
      designWidth: 412,
      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
        routes: {
          '/homePage': (context) => const HomePage(),
          '/loginOrSignup':(context)=>const LoginOrSignup(),
        },
      ),
    );
  }
}
