import 'package:flutter/material.dart';
import 'package:to_do/main.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      onLongPress: onPressed,
      elevation: 20,
      onPressed: onPressed,
      color: isDark ? Colors.grey.shade800 : Colors.deepPurple.shade500,
      child: Text(text, style: TextStyle(color: Colors.white),),
    );
  }
}
