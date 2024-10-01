import 'package:e_commerce_app/core/services/api/api_services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService{
  final Stripe _stripe = Stripe.instance;
  final ApiServices _apiServices;

  StripeService(this._apiServices);




}