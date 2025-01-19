import 'package:firebase_auth/firebase_auth.dart';

// Service class for Firebase Authentication. Add more as per your requirement

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ------------------- Method to create user with email and password ----------------//
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final emailResult   = await sendEmailVerification();
      _auth.signOut(); // Sign out user. FirebaseAuth create user function automatically signs in the User.
      return "Sign up successful!\n$emailResult";
    } catch (e) {
      return _handleError(e);
    }
  }

  // ------------------- Method to send email verification ----------------//
  Future<String?> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return "Verification email sent. Please check your inbox.";
      } else if (user != null && user.emailVerified) {
        return "Email is already verified.";
      } else {
        return "No user is currently signed in.";
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  // ------------------- Method to log in user with email and password ----------------//
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser!.emailVerified) {
        return "Login successful!";
      }else{
        _auth.signOut(); // Sign in func also sign's in the user.
        return "Email not verified";
      }
      
    } catch (e) {
      return e.toString();
    }
  }

  // ------------------- Method to Log out----------------//
  Future<void> logout() async {
    await _auth.signOut();
  }

// ------------------- Method to handle errors  ----------------//

  String _handleError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-credential':
          return "Invalid Credentials";
        case 'email-already-in-use':
          return "Email already in use.";
        case 'weak-password':
          return "Password is too weak.";
        case 'invalid-email':
          return "Invalid email format.";
        // Handle other potential FirebaseAuthExceptions
        case 'too-many-requests':
          return "Too many requests. Please try again later.";
        case 'operation-not-allowed':
          return "This operation is not allowed. Please contact support.";
        // ... add more cases as needed
        default:
          return "An unexpected error occurred.";
      }
    } else {
      // Handle other types of exceptions
      return "An unknown error occurred.";
    }
  }

  //---------------------Method to get current user------------------------//

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
