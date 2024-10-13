import 'package:e_commerce_app/core/services/api/api_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  void sendToTopic() async {}

}
