import 'package:e_commerce_app/core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/services/fcm/fcm_service.dart';
import 'package:e_commerce_app/core/services/stripe/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  final token = await FCMService(DioServices()).getToken();
  print("token is ------->$token");
  FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);

  runApp(const BuyItApp());
}

// Handler for processing messages when the app is in the background or terminated.
// when a [background] notification [received].
@pragma('vm:entry-point')
Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification?.body}");
}
