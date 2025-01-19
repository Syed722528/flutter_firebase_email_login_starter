import 'package:flutter/material.dart';

// This can be used instead of showing red text to user regarding the auth messages


void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.indigoAccent,
      behavior: SnackBarBehavior.floating, // Makes it float above content
      margin: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10), // Adds padding around it
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adds rounded corners
      ),
      duration: const Duration(seconds: 3), // Custom display duration
    ),
  );
}
