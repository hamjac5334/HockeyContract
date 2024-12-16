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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About D'Crease",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Welcome to D'Crease! This application allows hockey coaches and scouts to rate youth "
              "hockey goaltenders on their ability on the ice to evaluate, compare, and see players' progress.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "Pages",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Goalenders Page: This is where to view the goaltenders and add new goaltenders \n\n"
              "Evaluation Page: This is where to view the evaluations that have been made or create a new evaluation\n\n"
              "Organization Page: List of organizations\n\n"
              "FAQ Page: This page provides an opportunity to troubleshoot or look at frequently asked questions if the user is having trouble with something in the app or would like to know more about functionality.\n\n"
              "App Navigation: App is navigable through the drawer that opens on the upper left side of the screen or through the home page\n",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Auth {
  Future<void> signOut() async {
    // Mock sign-out action
    print('Signed out');
  }
}