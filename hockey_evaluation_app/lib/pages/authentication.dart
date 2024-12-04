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
        Text(
          'Welcome to the Hockey App', // The welcome message
          style: TextStyle(
            fontSize: 24, // Adjust the font size
            fontWeight: FontWeight.bold, // Make it bold
            color: Colors.black, // Adjust the color if needed
          ),
          textAlign: TextAlign.center, // Center the text
        ),
        SizedBox(height: 20), // Space between the text and the image
        Flexible(
          // This prevents the overflow
          child: Image.asset(
            'lib/image/logo.png', // Path to image file
            height: 175,
            width: double.infinity,
            fit: BoxFit.cover, // Adjust height as needed
          ),
        ),
      ]),
    );
  }
}
