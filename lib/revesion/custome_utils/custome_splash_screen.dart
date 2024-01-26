import 'dart:async';

import 'package:blogapp/revesion/custome_screen/custome_login.dart';
import 'package:flutter/material.dart';

class CustomeSplashService {
  void login(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (cotext) => CustomeLoginScreen()));
    });
  }
}
