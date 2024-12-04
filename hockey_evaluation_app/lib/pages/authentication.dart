import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          // This prevents the overflow
          child: Image.asset(
            'lib/image/logo.png', // Path to image file
            height: 175,
            width: double.infinity,
            fit: BoxFit.cover, // Adjust height as needed
          ),
        ),
        SizedBox(height: 20),
        const Text(
          "Welcome to D'Crease! This application allows hockey coaches and scouts to rate youth "
          "hockey goaltenders on their ability on the ice to evaluate, compare, and see players' progress.",
          style: TextStyle(
            fontSize: 12, // Adjust the font size
            color: Colors.black,
            // TextAlign: TextAlign.center, // Center the text
          ),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
