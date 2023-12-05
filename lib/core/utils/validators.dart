import 'package:e_commerce_app/core/utils/app_strings.dart';

class Validators {
  static String? stringValidator(value, String message) {
    // Regular expression pattern to match valid names (letters, spaces, hyphens, and apostrophes)
    const pattern = r"^[a-zA-Z\s\-\'\’]+$";
    final regExp = RegExp(pattern);

    if (value.isEmpty || !regExp.hasMatch(value)) {
      return AppStrings.invalid + message; // Name is empty or null
    }

    return null;
  }

  static String? numericValidator(value, String message) {
    if (value.isEmpty || double.tryParse(value) == null) {
      return AppStrings.invalid + message;
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value.isEmpty) {
      return AppStrings.enterYourEmail;
    } else if (!_isValidEmail(email: value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value.isEmpty) {
      return AppStrings.enterYourPassword;
    } else if (!_isValidPassword(password: value)) {
      return AppStrings.invalidPassword;
    }

    return null;
  }

  static bool _isValidPassword({
    required String password,
  }) {
    // Check the length of the input.
    if (password.length < 8) {
      return false;
    }

    // Check if the password contains only alphabets.
    final isAlphabetic = RegExp(r'^[a-zA-Z]+$').hasMatch(password);
    if (isAlphabetic) {
      return false;
    }

    // Check if the password contains only digits.
    final isNumeric = int.tryParse(password) != null;
    if (isNumeric) {
      return false;
    }

    // All conditions passed, so the passwordController.text is valid.
    return true;
  }

  static bool _isValidEmail({
    required String email,
  }) {
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }
}
