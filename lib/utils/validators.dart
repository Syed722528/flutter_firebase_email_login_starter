
class Validators {

  //-----------------Validator for email------------------------//
static String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }

  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(email)) {
    return 'Please enter a valid email address';
  }

  return null; // Email is valid
}


  //------------------Validator for password-------------------//

  static String? validatePassword(String? password){
    if(password==null||password.isEmpty){
      return 'Password is required';
    }
    if(password.length<6){
      return 'Password must be atleast 8 characters long';
    }
    return null; // Password is valid
  }

  //------------------Validator for Confirm password-----------------//
  static String? validateConfirmPassword(String? password, String? confirmPassword){
    if (confirmPassword==null||confirmPassword.isEmpty) {
      return 'Please confirm you password';
    }
    if(password!=confirmPassword){
      return 'Passwords do not match';
    }
    return null; // Confirm password is valid and matched
  }
}