import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/item_score.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:go_router/go_router.dart';

class TheseSettings extends StatefulWidget {
  const TheseSettings({super.key});

  @override
  State<TheseSettings> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<TheseSettings> {
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 80, 78, 78),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
            "This is just a placeholder until I know what goes on this screen"),
      ),
    );
  }
}

// Assuming a mock Auth class for signOut functionality
class Auth {
  Future<void> signOut() async {
    // Mock sign-out action
    print('Signed out');
  }
}
