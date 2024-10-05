
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
