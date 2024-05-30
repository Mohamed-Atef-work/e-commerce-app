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
    } else if (!_isValidEmail(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value.isEmpty) {
      return AppStrings.enterYourPassword;
    } else if (!_isValidPassword(value)) {
      return AppStrings.invalidPassword;
    }

    return null;
  }

  static String? addressValidator(value, String message) {
    // Check if the address contains at least one digit
    RegExp regex = RegExp(r'\d');
    if (value.isEmpty || !regex.hasMatch(value)) {
      return AppStrings.invalid + message;
    }
    return null;
  }

  static String? descriptionValidator(description) {
    // Check if the description is empty
    if (description.isEmpty || description.length < 30) {
      return AppStrings.invalid + AppStrings.productDescription;
    }

    return null;
  }

  static bool _isValidPassword(String password) {
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

  static bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }
}
