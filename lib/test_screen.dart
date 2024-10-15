import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/services/fcm/constants.dart';
import 'package:e_commerce_app/core/services/fcm/fcm_service.dart';
import 'package:flutter/material.dart';
import 'core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final data = {
              "Hello": "Hi",
              "Good Morning": "Good Evening",
            };
            final fcm = FCMService(DioServices());
            final notification = NotificationModel(
              title: "Hello",
              body: "I'm testing the new way of doing the notification with models instead of Maps! :)",
            );
            final message = MessageModel(
              data: data,
              notification: notification,
              token: FCMConstants.deviceToken,
            );
            await fcm.apiNotification(message);
          },
          child: const CustomText(text: "Add"),
        ),
      ),
    );
  }
}
