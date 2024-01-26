import 'package:blogapp/revesion/custome_screen/custome_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class VerifyNumber extends StatefulWidget {
  final String verifyid;
  const VerifyNumber({super.key, required this.verifyid});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final auth = FirebaseAuth.instance;
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(
              onPressed: () async {
                final creadential = PhoneAuthProvider.credential(
                    verificationId: widget.verifyid,
                    smsCode: phoneController.text);
                await auth.signInWithCredential(creadential).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomeLoginScreen()));
                }).onError((error, stackTrace) {
                  print('something is wrong');
                });
              },
              child: Text('Verify OTP'))
        ],
      ),
    );
  }
}
