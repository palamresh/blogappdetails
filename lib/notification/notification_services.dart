import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  void initializedNotification() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channel Id', 'channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: "ticker");

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails);
  }

  void sechedulingNotification(String title, String body) async {
    print('secheduling notification');
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channel Id', 'channel name',
            ticker: 'ticker',
            importance: Importance.max,
            priority: Priority.high);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0, title, body, RepeatInterval.everyMinute, notificationDetails);
  }

  void stopNotification() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }
}
