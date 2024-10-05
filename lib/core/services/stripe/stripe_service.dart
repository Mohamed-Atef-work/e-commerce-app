import 'package:dio/dio.dart';
import 'params/Init_payment_sheet.dart';
import 'params/create_payment_intent.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/services/api/api_services.dart';
import 'package:e_commerce_app/core/services/stripe/constants.dart';
import 'package:e_commerce_app/core/services/stripe/models/ephemeral_key.dart';

class StripeService {
  final ApiServices _apiServices;

  final Stripe _stripe = Stripe.instance;

  StripeService(this._apiServices);

  Future<String> createPaymentIntent(CreateIntentParams params) async {
    final apiParams = ApiPostParams(
      data: params.toJson(),
      url: StripeConstants.createPaymentIntentUrl(),
      contentType: Headers.formUrlEncodedContentType,
      headers: {kAuthorization: "$kBearer ${StripeConstants.secretKey}"},
    );
    final result = await _apiServices.post(apiParams) as Response;
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

    final ephemeralKeyModel = EphemeralKeyModel.fromJson(result.data);
    return ephemeralKeyModel.secret!;
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
      final createIntentParams = CreateIntentParams(
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
