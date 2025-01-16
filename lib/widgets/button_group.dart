import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  final bool isLoginSelected;
  final VoidCallback onLoginPressed;
  final VoidCallback onSignUpPressed;
  const ButtonGroup(
      {super.key,
      required this.isLoginSelected,
      required this.onLoginPressed,
      required this.onSignUpPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 5,
        children: [
          ElevatedButton(
            onPressed: onLoginPressed,
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    isLoginSelected ? Colors.purple : Colors.purpleAccent,
                shape: LinearBorder.end()),
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: onSignUpPressed,
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    isLoginSelected ? Colors.purpleAccent : Colors.purple,
                shape: LinearBorder.end()),
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
