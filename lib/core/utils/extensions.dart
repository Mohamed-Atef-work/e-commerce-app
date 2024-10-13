import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension DioErrorMessage on DioException {
  String get errorMessageFromType {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Time out.";
      case DioExceptionType.sendTimeout:
        return "Send Time out.";
      case DioExceptionType.receiveTimeout:
        return "Receive Time out.";
      case DioExceptionType.badCertificate:
        return "Bad Certificate.";
      case DioExceptionType.badResponse:
        return "Bad Response.";
      case DioExceptionType.cancel:
        return "Request Canceled.";
      case DioExceptionType.connectionError:
        return "Connection Error.";
      case DioExceptionType.unknown:
        return "Unknown Error Pleas, try again later.";
    }
  }
}

extension StripeErrorMessage on StripeException {
  String get errorMessageFromCode {
    switch (error.code) {
      case FailureCode.Failed:
        return "Request Failed";
      case FailureCode.Canceled:
        return "Request Canceled.";
      case FailureCode.Timeout:
        return "Timeout For Request.";
      case FailureCode.Unknown:
        return "Unknown Error Please, Try Again Later.";
    }
  }
}

extension FirebaseErrorMessage on FirebaseException {
  String get errorMessageFromCode {
    switch (code) {
      case 'unknown':
        return 'An Unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return "The custom token format is incorrect. Please check your custom token.";
      case 'custom-token-mismatch':
        return "The custom token corresponds to a different audience.";
      case 'user-disabled':
        return "The user account has been disabled.";
      case 'user-not-found':
        return "No user found for the given email or ID.";
      case 'invalid-email':
        return "The email address provided is invalid. Please enter a valid email.";
      case 'email-already-in-use':
        return "The email address is already registered. Please use a different email.";
      case 'wrong-password':
        return "Incorrect password. Please check your password and try again.";
      case 'weak-password':
        return "The password is too weak. Please choose a stronger password.";
      case 'provider-already-linked':
        return "The account is already linked with another provider.";
      case 'operation-not-allowed':
        return "This operation is not allowed. Contact support for assistance.";

      // Add more Firebase error codes and messages here
      case 'invalid-credential':
        return 'The provided credential is invalid.';
      case 'invalid-verification-code':
        return 'The provided verification code is invalid.';
      case 'invalid-verification-id':
        return 'The provided verification ID is invalid.';
      case 'argument-error':
        return 'An invalid argument was provided to a Firebase function.';
      case 'timeout':
        return 'A timeout occurred while communicating with Firebase servers.';
      case 'quota-exceeded':
        return 'The quota for this operation has been exceeded.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'network-error':
        return 'A network error occurred while communicating with Firebase.';
      case 'internal-error':
        return 'An internal error occurred in the Firebase backend.';
      case 'invalid-api-key':
        return 'The provided API key is invalid.';
      case 'permission-denied':
        return 'The current user does not have permission to perform this operation.';
      case 'missing-android-configuration-file':
        return 'The Android configuration file for Firebase is missing.';
      case 'missing-ios-plist-file':
        return 'The iOS plist file for Firebase is missing.';
      case 'unverified-email':
        return 'The user\'s email address is not verified.';
      default:
        return "An error occurred during the Firebase operation. Please try again.";
    }
  }
}

extension FirebaseAuthErrorMessage on FirebaseAuthException {
  String get errorMessageFromCode {
    switch (code) {
      case 'too-many-requests':
        return 'Too many failed login attempts, login temporarily disabled. Please try again in a few minutes';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';

      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign in again.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      case 'invalid-recipient-email':
        return 'The email template recipient\'s email is invalid. Please verify the recipient\'s email.';

      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials.';

      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}

extension PlatformErrorMessage on PlatformException {
  String get errorMessageFromCode {
    switch (code) {
      case 'invalid-email-format':
        return 'The email address format is invalid. Please enter a valid email.';
      case 'invalid-phone-number-format':
        return 'The provided phone number format is invalid. Please enter a valid number.';
      case 'invalid-date-format':
        return 'The date format is invalid. Please enter a valid date.';
      case 'invalid-url-format':
        return 'The URL format is invalid. Please enter a valid URL.';
      case 'invalid-credit-card-format':
        return 'The credit card format is invalid. Please enter a valid credit card number.';
      case 'invalid-numeric-format':
        return 'The input should be a valid numeric format.';
      // Add more cases as needed...
      default:
        return 'Unsupported format code: $code';
    }
  }
}
