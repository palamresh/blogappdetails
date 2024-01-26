import 'package:blogapp/blogeample/components/round_button.dart';
import 'package:blogapp/blogeample/screen/login_screen.dart';
import 'package:blogapp/blogeample/screen/register_screen.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Blog App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                'https://tse4.mm.bing.net/th?id=OIP.64aQD8n4PgBZn6QD3b8BnwHaEK&pid=Api&P=0&h=180',
                height: 300,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: 'Login',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: 'Register',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
