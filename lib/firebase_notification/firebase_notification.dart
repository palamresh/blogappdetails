import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void initializedNotification(
      BuildContext context, RemoteMessage message) async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      if (Platform.isAndroid) {
        initializedNotification(context, message);
        sendNotification(message);
      }
    });
  }

  void sendNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', 'high_importance_channel',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: "your channel description",
            importance: Importance.high,
            priority: Priority.high,
            ticker: "ticker");

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails);
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      criticalAlert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User permissin is granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user provisional is granted");
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('permission is denied');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    return token!;
  }

  void isRefressToken() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refress Device Token');
    });
  }
}
