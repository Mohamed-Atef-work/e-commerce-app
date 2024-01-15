import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce_app/buy_it_app.dart';
import 'core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  print(DateTime.now());
  /// To D0000000
  /// handle Login in order to ----->
  /// ..........-_-_-_--> Take his [Id] to GET {FAVORITES} and {ORDERS}
  /// store user data [firebase] ....................................... [[Done]]
  /// store user data [locally]
  /// Orders Screen For [User]
  /// Orders Screen For [Admin]
  /// Favorites Screen
  /// Cart Screen ...................................................... [[Done]]
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocatorInit();
  runApp(const BuyItApp());
}
