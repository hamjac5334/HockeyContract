import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/item_score.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:go_router/go_router.dart';

class TheseFAQ extends StatefulWidget {
  const TheseFAQ({super.key});

  @override
  State<TheseFAQ> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<TheseFAQ> {
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
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
            
            const SizedBox(height: 16),
            const Text(
              "FAQ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Q: How do I add a new goaltender?\n"
              "A: You can add a new goaltender by clicking the add button in the bottom right corner of the Goaltenders Page\n\n"
              "Q: How do I add a new evaluation?\n"
              "A: You can add a new evaluation by clicking the add button in the bottom right corner of the Evaluations Page\n\n",
              
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