import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_login_starter/services/firebase_auth.dart';
import 'package:flutter_firebase_email_login_starter/utils/validators.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onPressed;
  const SignupPage({super.key, required this.onPressed});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  final AuthService _authService = AuthService();
  String _message = '';

  Future<void> _signUp() async {
    final email = _email.text.trim();
    final password = _password.text.trim();
    String? result = await _authService.signUp(email, password);
    if (result == "Sign up successful!") {
      String? emailResult = await _authService.sendEmailVerification();
      setState(() {
        _message = "$result\n$emailResult";
      });
    }else{
      setState(() {
        _message = result!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void toggelConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20.rs),
            width: 350.rw,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: signUpForm(),
          ),
        ),
      ),
    );
  }

  Form signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20.rw,
        children: [
          Text(
            'Create an account',
            style: TextStyle(fontSize: 30.rs, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
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
            obscureText: !_showPassword,
            controller: _password,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: togglePasswordVisibility,
                  icon: _showPassword
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
          TextFormField(
            obscureText: !_showConfirmPassword,
            controller: _confirmPassword,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: toggelConfirmPasswordVisibility,
                  icon: _showConfirmPassword
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(5.0),
              filled: true,
              hintText: 'Confirm Password',
              label: Text('Confirm Password'),
            ),
            validator: (confirmPassword) => Validators.validateConfirmPassword(
                _password.text, confirmPassword),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _signUp();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(),
              animationDuration: Duration(seconds: 3),
              shadowColor: Colors.grey,
              enableFeedback: true,
              elevation: 5,
            ),
            child: Text('Create Account'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? "),
              GestureDetector(
                  onTap: widget.onPressed,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Text(_message, style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
