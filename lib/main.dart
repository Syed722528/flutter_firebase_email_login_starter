import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:simplelogin/services/login_or_signup.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexify(
      designHeight: 912,
      designWidth: 412,
      app:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginOrSignup(),
      ),
    );
  }
}