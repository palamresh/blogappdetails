import 'package:blogapp/blogeample/screen/forgot_password.dart';
import 'package:blogapp/blogeample/screen/login_with_phone.dart';
import 'package:blogapp/blogeample/screen/splash_screen.dart';
import 'package:blogapp/notification/localnotification.dart';
import 'package:blogapp/revesion/custome_screen/custome_login.dart';
import 'package:blogapp/revesion/custome_utils/custome_splash_screen.dart';
import 'package:blogapp/revesion/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
      home: LocalNotification(),
    );
  }
}
