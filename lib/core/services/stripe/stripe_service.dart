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
    final apiParams = _createIntentPostParams(params);
    final result = await _apiServices.post(apiParams) as Response;
    final clientSecret = result.data[kClientSecret];
    print(clientSecret);
    return clientSecret;
  }

  Future<String> createEphemeralKey(String customerId) async {
    final params = _createEphemeralKeyPostParams(customerId);
    final result = await _apiServices.post(params) as Response;

    final ephemeralKeyModel = EphemeralKeyModel.fromJson(result.data);
    print(ephemeralKeyModel.secret!);
    return ephemeralKeyModel.secret!;
  }

  Future<void> initPaymentSheet(InitSheetParams params) async {
    final setupParams = _setUpPaymentSheetParams(params);
    await _stripe.initPaymentSheet(paymentSheetParameters: setupParams);
  }

  Future<PaymentSheetPaymentOption?> presentPaymentSheet() async =>
      await _stripe.presentPaymentSheet();

  Future<void> payWithSheet({
    required int amount,
    required String currency,
    required String customerId,
  }) async {
    final ephemeralKey = await createEphemeralKey(customerId);
    print(ephemeralKey);
    final createIntentParams = CreateIntentParams(
      currency: currency,
      amount: amount * 100,
      customerId: customerId,
    );
    final clientSecret = await createPaymentIntent(createIntentParams);
    print(clientSecret);
    final initSheetParams =
        _initSheetParams(customerId, ephemeralKey, clientSecret);
    await initPaymentSheet(initSheetParams);
    await _stripe.presentPaymentSheet();
  }

  ApiPostParams _createIntentPostParams(CreateIntentParams params) =>
      ApiPostParams(
        data: params.toJson(),
        url: StripeConstants.createPaymentIntentUrl(),
        contentType: Headers.formUrlEncodedContentType,
        headers: {kAuthorization: "$kBearer ${StripeConstants.secretKey}"},
      );

  ApiPostParams _createEphemeralKeyPostParams(String customerId) =>
      ApiPostParams(
        data: {kCustomer: customerId},
        url: StripeConstants.createEphemeralKeyUrl(),
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          kStripeVersion: StripeConstants.version,
          kAuthorization: "$kBearer ${StripeConstants.secretKey}"
        },
      );

  SetupPaymentSheetParameters _setUpPaymentSheetParams(
          InitSheetParams params) =>
      SetupPaymentSheetParameters(
        paymentIntentClientSecret: params.paymentIntentClientSecret,
        customerEphemeralKeySecret: params.ephemeralKey,
        customerId: params.customerId,
        merchantDisplayName: 'Buy it',
      );

  InitSheetParams _initSheetParams(
    String customerId,
    String ephemeralKey,
    String clientSecret,
  ) =>
      InitSheetParams(
        customerId: customerId,
        ephemeralKey: ephemeralKey,
        paymentIntentClientSecret: clientSecret,
      );
}
