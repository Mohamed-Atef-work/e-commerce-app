import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';

class ServerException implements Exception {
  final String message;
  final Object? object;
  const ServerException({
    required this.message,
    this.object,
  });

  factory ServerException.fromDioException(DioException exception) =>
      ServerException(
        object: exception.response,
        message: exception.errorMessageFromType,
      );

  factory ServerException.fromStripeException(StripeException exception) =>
      ServerException(
        object: exception.error.localizedMessage,
        message: exception.errorMessageFromCode,
      );
}

class LocalDataBaseException implements Exception {
  final String message;
  const LocalDataBaseException({required this.message});
}
