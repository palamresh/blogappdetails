import 'package:blogapp/blogeample/components/round_button.dart';
import 'package:blogapp/blogeample/components/utils.dart';
import 'package:blogapp/blogeample/screen/forgot_password.dart';
import 'package:blogapp/blogeample/screen/home_page.dart';
import 'package:blogapp/blogeample/screen/login_with_phone.dart';
import 'package:blogapp/blogeample/screen/register_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _ReiesterPageState();
}

class _ReiesterPageState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      label: Text('Email'),
                      hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: 'X',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_clock_outlined),
                      label: Text('Password'),
                      hintText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    } else if (value.length < 6) {
                      return 'Please Enter 6 digit Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text('Forgot Password'))),
                SizedBox(
                  height: 10,
                ),
                RoundButton(
                    title: 'Login',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {});
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString());
                          // ignore: unnecessary_null_comparison
                          if (user != null) {
                            print('successful Login');
                            Util().toastMessage('Successfull Login');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlogPage()));
                          }
                        } catch (e) {
                          print(e.toString());
                          Util().toastMessage(e.toString());
                        }
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('I don\'t have any account '),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text("Register "))
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginWithNumber()));
                    },
                    child: Text("Login With Phone"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
