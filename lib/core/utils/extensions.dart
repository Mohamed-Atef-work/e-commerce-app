import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
