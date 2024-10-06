import 'package:e_commerce_app/modules/user/domain/repository/payment.dart';
import 'package:e_commerce_app/core/services/stripe/stripe_service.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';

abstract class PaymentDataSource {
  Future<void> pay(PayParams params);
}

class StripDataSource implements PaymentDataSource {
  final StripeService _service;

  StripDataSource(this._service);
  @override
  Future<void> pay(PayParams params) async {
    try {
      final response = await _service.payWithSheet(
        amount: params.amount,
        currency: params.currency,
        customerId: params.customerId,
      );
      return response;
    } on DioException catch (exc) {
      final serverException = ServerException.fromDioException(exc);
      print("localizedMessage ----->${exc.errorMessageFromType}");
      print("error -----> ${exc.error}");
      print("response -----> ${exc.response}");
      throw serverException;
    } on StripeException catch (exc) {
      final serverException = ServerException.fromStripeException(exc);
      print("localizedMessage -----> ${exc.error.localizedMessage}");
      print("message -----> ${exc.error.message}");
      print("type -----> ${exc.error.type}");
      print("errorMessageFromCode -----> ${exc.errorMessageFromCode}");
      throw serverException;
    } catch (exc) {
      final serverException = ServerException(message: exc.toString());
      throw serverException;
    }
  }
}
