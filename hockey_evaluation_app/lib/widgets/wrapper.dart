import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/widgets/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Wrapper extends StatelessWidget {
  Wrapper({super.key});

bool loggedin = true;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      loggedin = false;
    } else {
      print('User is signed in!');
      print(user.uid);
      loggedin = true;
    }
  });
  //need to set this up to listeners.
  if (loggedin == true){
    return MyHomePage(title: 'Hockey Evaluation App');
  }
  else{
    return Authenticate();
  }
  }
}