import 'package:blogapp/blogeample/components/round_button.dart';
import 'package:blogapp/blogeample/components/utils.dart';
import 'package:blogapp/blogeample/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  late Animation<double> iconAnimation;
  late AnimationController animationController;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: (Duration(microseconds: 400)));
    iconAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    iconAnimation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  final resetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: animationController.value * 200,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Colors.blue),
              controller: resetController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Reset Password'),
            ),
            SizedBox(
              height: 10,
            ),
            RoundButton(
                title: 'Reset Password',
                onPressed: () {
                  auth
                      .sendPasswordResetEmail(
                          email: resetController.text.toString())
                      .then((value) {
                    Util().toastMessage('Please Check your Email ');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    Util().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
