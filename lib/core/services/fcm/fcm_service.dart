import 'package:e_commerce_app/core/services/api/api_services.dart';
import 'package:e_commerce_app/core/services/api/dio_services.dart';
import 'package:e_commerce_app/core/services/fcm/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class FCMService {
  final ApiServices _apiServices;
  final _fcm = FirebaseMessaging.instance;

  FCMService(this._apiServices);

  Future<String?> getToken() async => await _fcm.getToken();

  // when [Terminated-app] notification is [clicked].
  //it fetches the message that caused the app to open, so you can handle it accordingly.
  //when the app is completely closed.
  Future<RemoteMessage?> interactTerminated() async {
    final message = await _fcm.getInitialMessage();
    return message;
  }

  // when a [background] notification is [clicked].
  Stream<RemoteMessage> interactBackGround() =>
      FirebaseMessaging.onMessageOpenedApp;

  // when a [foreground] notification is [received].
  Stream<RemoteMessage> receiveForGround() => FirebaseMessaging.onMessage;

  // Handler for processing messages when the app is in the background or terminated.
  // when a [background] and [Terminated] notification [received].
  // FirebaseMessaging.onBackgroundMessage(handler);

  Future<NotificationSettings> settings() async => await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        provisional: false,
        announcement: false,
        criticalAlert: false,
      );

  Future<void> subscribeToTopic(String topic) async =>
      await _fcm.subscribeToTopic(topic);

  Future<void> unSubscribeFromTopic(String topic) async =>
      await _fcm.unsubscribeFromTopic(topic);

  Future<String> getAccessToken() async {
    final serviceCredentials = auth.ServiceAccountCredentials.fromJson(
        FCMConstants.serviceAccountJson);

    http.Client client = await auth.clientViaServiceAccount(
      serviceCredentials,
      FCMConstants.scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      serviceCredentials,
      FCMConstants.scopes,
      client,
    );

    client.close();
    print(
        "Access Token: ${credentials.accessToken.data}"); // Print Access Token
    return credentials.accessToken.data;
  }

  Future<void> apiNotification(MessageModel message) async {
    final accessToken = await getAccessToken();
    final params = ApiPostParams(
      data: message.toJson(),
      url: FCMConstants.baseUrl,
      contentType: kApplicationJson,
      headers: {kAuthorization: "$kBearer $accessToken"},
    );
    await _apiServices.post(params);
  }
}

class MessageModel {
  final String token;
  final String? topic;
  final Map<String, dynamic> data;
  final NotificationModel notification;

  MessageModel({
    required this.token,
    this.topic,
    required this.data,
    required this.notification,
  });

  Map<String, dynamic> toJson() => {
        "message": {
          "data": data,
          "token": token,
          "notification": notification.toJson(),
        }
      };
}

class NotificationModel {
  final String body;
  final String title;

  NotificationModel({required this.title, required this.body});

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
      };
}
