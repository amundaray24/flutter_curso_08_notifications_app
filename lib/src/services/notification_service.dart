import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  static final StreamController<String> _messageStream = StreamController();
  static Stream<String> get messageStream => _messageStream.stream;
  static String? token;

  static initNotificationsService() async {

    await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();

    print('TOKEN: $token');

    FirebaseMessaging.instance.app;

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static Future _onBackgroundMessage( RemoteMessage message) async {
    print('_onBackgroundMessage Handler => ${message.messageId}');
    _messageStream.add(message.data['userId'] ?? '');
  }

  static Future _onMessage( RemoteMessage message) async {
    print('_onMessage Handler => ${message.messageId}');
    _messageStream.add(message.data['userId'] ?? '');
  }

  static Future _onMessageOpenedApp( RemoteMessage message) async {
    print('_onMessageOpenedApp Handler => ${message.messageId}');
    _messageStream.add(message.data['userId'] ?? '');
  }
}