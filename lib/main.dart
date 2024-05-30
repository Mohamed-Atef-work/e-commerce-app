import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce_app/buy_it_app.dart';
import 'core/services/service_locator/sl.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  print(DateTime.now());

  await sl.allReady();
  serviceLocatorInit();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const BuyItApp());
}
