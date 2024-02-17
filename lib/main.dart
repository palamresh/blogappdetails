import 'package:blogapp/blogeample/screen/forgot_password.dart';
import 'package:blogapp/blogeample/screen/login_with_phone.dart';
import 'package:blogapp/blogeample/screen/splash_screen.dart';
import 'package:blogapp/dowload_image_contianer.dart/folder_name_do.dart';
import 'package:blogapp/notification/localnotification.dart';
import 'package:blogapp/revesion/custome_screen/custome_login.dart';
import 'package:blogapp/revesion/custome_utils/custome_splash_screen.dart';
import 'package:blogapp/revesion/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  print('hii hellow');
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 84, 3, 89)),
        useMaterial3: true,
      ),
      home: DownloadFolderName(),
    );
  }
}
