import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';

abstract class PaymentRepo {
  Future<Either<Failure, void>> pay(PayParams params);
}

class PayParams {
  final int amount;
  final String currency;
  final String customerId;

  PayParams({
    required this.amount,
    required this.currency,
    required this.customerId,
  });
}
