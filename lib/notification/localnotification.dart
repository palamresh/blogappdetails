import 'package:blogapp/notification/notification_services.dart';
import 'package:flutter/material.dart';

class LocalNotification extends StatefulWidget {
  const LocalNotification({super.key});

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  final NotificationService notificationService = NotificationService();
  @override
  void initState() {
    notificationService.initializedNotification();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Local Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  notificationService.sendNotification(
                      'this is a title', 'this is a body');
                },
                child: Text("Send Notification")),
            ElevatedButton(
                onPressed: () {}, child: Text("Scheduling Notification")),
            ElevatedButton(onPressed: () {}, child: Text("Stop Notifiation"))
          ],
        ),
      ),
    );
  }
}
