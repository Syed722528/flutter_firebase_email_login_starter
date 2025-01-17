import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  final AuthService _authService = AuthService();

  String _message = '';
  void _signIn() async {
    final email = _email.text.trim();
    final password = _password.text.trim();
    String? result = await _authService.login(email, password);
    setState(() {
      _message = result ?? '';
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return logIn();
  }

  Expanded logIn() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loginForm(),
        ],
      ),
    );
  }

  Form loginForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.rs),
        height: 400.rh,
        width: 350.rw,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20.rw,
            children: [
              Text(
                'Login to Continue',
                style: TextStyle(fontSize: 30.rs, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5.0),
                  filled: true,
                  hintText: 'Enter your Email',
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email Required';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: !showPassword,
                controller: _password,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: togglePassword,
                      icon: showPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5.0),
                  filled: true,
                  hintText: 'Enter your password',
                  label: Text('Password'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password Required';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signIn();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    animationDuration: Duration(seconds: 3),
                    shadowColor: Colors.grey,
                    enableFeedback: true,
                    elevation: 5),
                child: Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                      onTap: widget.onPressed,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Text(_message, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
