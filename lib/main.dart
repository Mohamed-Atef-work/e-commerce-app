import 'package:e_commerce_app/core/services/stripe/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce_app/buy_it_app.dart';
import 'config/service_locator/sl.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  print(DateTime.now());

  await sl.allReady();
  serviceLocatorInit();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeConstants.publishableKey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const BuyItApp());
}
