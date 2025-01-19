import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/utils/validators.dart';
import 'package:flutter_firebase_email_login_starter/widgets/custom_button.dart';

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

  // Creating instance of Auth Service class
  final AuthService _authService = AuthService();

  // To display message to the user either error or success. Alert Dialog or Snack bar can be used
  String _message = '';

  //Function to sign in user
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
        height: 400.rh, // Responsive height
        width: 350.rw, // Responsive width
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
                validator: (email) => Validators.validateEmail(email),
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
                validator: (password) => Validators.validatePassword(password),
              ),
              CustomButton(
                  buttonText: 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signIn();
                      if (_message == 'Login successful!') {
                        Navigator.pushNamed(context, '/homePage');
                      }
                    }
                  }),
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
