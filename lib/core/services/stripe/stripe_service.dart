import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/services/api/api_services.dart';
import 'package:e_commerce_app/core/services/stripe/constants.dart';

class StripeService {
  final ApiServices _apiServices;

  final Stripe _stripe = Stripe.instance;

  StripeService(this._apiServices);

  Future<String> createPaymentIntent(InputIntentModel model) async {
    final params = ApiPostParams(
      data: model.toJson(),
      url: StripeConstants.createPaymentIntentUrl(),
      contentType: Headers.formUrlEncodedContentType,
      headers: {kAuthorization: "$kBearer ${StripeConstants.secretKey}"},
    );
    final result = await _apiServices.post(params) as Response;
    final clientSecret = result.data[kClientSecret];
    return clientSecret;
  }

  Future<String> createEphemeralKey(String customerId) async {
    final params = ApiPostParams(
      data: {kCustomer: customerId},
      url: StripeConstants.createEphemeralKeyUrl(),
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        kStripeVersion: StripeConstants.version,
        kAuthorization: "$kBearer ${StripeConstants.secretKey}"
      },
    );
    final result = await _apiServices.post(params) as Response;

    final ephemeralKey = result.data["secret"];
    return ephemeralKey;
  }

  Future<void> initPaymentSheet(InitSheetParams params) async {
    final setupParams = SetupPaymentSheetParameters(
      paymentIntentClientSecret: params.paymentIntentClientSecret,
      customerEphemeralKeySecret: params.ephemeralKey,
      customerId: params.customerId,
      merchantDisplayName: 'Buy it',
    );
    await _stripe.initPaymentSheet(paymentSheetParameters: setupParams);
  }

  Future<void> pay(int amount, String currency, String customerId) async {
    try {
      final ephemeralKey = await createEphemeralKey(customerId);
      print(ephemeralKey);
      final createIntentParams = InputIntentModel(
        amount: amount,
        currency: currency,
        customerId: customerId,
      );
      final clientSecret = await createPaymentIntent(createIntentParams);
      print(clientSecret);
      final initSheetParams = InitSheetParams(
        customerId: customerId,
        ephemeralKey: ephemeralKey,
        paymentIntentClientSecret: clientSecret,
      );
      final initSheet = await initPaymentSheet(initSheetParams);
      await _stripe.presentPaymentSheet();
    } catch (e) {
      print(e.toString());
    }
  }
}

class InputIntentModel {
  final int amount;
  final String currency;
  final String customerId;

  InputIntentModel({
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

class InitSheetParams {
  final String customerId;
  final String ephemeralKey;
  final String paymentIntentClientSecret;

  InitSheetParams({
    required this.customerId,
    required this.ephemeralKey,
    required this.paymentIntentClientSecret,
  });
}
