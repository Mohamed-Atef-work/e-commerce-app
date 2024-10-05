import 'package:e_commerce_app/core/services/stripe/constants.dart';

class CreateIntentParams {
  final int amount;
  final String currency;
  final String customerId;

  CreateIntentParams({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  Map<String, dynamic> toJson() => {
    kAmount: amount,
    kCurrency: currency,
    kCustomer: customerId,
  };
}
