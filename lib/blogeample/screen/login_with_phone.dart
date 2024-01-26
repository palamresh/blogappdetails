import 'package:blogapp/blogeample/components/utils.dart';
import 'package:blogapp/blogeample/screen/verifyphonenumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithNumber extends StatefulWidget {
  const LoginWithNumber({
    super.key,
  });

  @override
  State<LoginWithNumber> createState() => _LoginWithNumberState();
}

class _LoginWithNumberState extends State<LoginWithNumber> {
  final _auth = FirebaseAuth.instance;
  final phoneController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send OTP'),
      ),
      body: Column(
        children: [
          TextField(
            controller: phoneController,
            decoration: InputDecoration(),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: loading
                ? Center(child: CircularProgressIndicator())
                : OutlinedButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      _auth.verifyPhoneNumber(
                          phoneNumber: phoneController.text,
                          verificationCompleted: (_) {},
                          verificationFailed: (e) {
                            setState(() {
                              loading = false;
                            });
                            Util().toastMessage(e.toString());
                          },
                          codeSent: (String verificationId,
                              int? forceResendingToken) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyNumber(
                                        verifyid: verificationId)));
                          },
                          codeAutoRetrievalTimeout: (e) {
                            setState(() {
                              loading = false;
                            });
                          });
                    },
                    child: Text("Login With Number")),
          )
        ],
      ),
    );
  }
}
