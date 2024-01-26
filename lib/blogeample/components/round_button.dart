import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  RoundButton({required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          height: 50,
          color: Color.fromARGB(255, 255, 89, 219),
          minWidth: double.infinity,
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          onPressed: onPressed),
    );
  }
}
