import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/widgets/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool loggedin = true;

class _wrapperStatefulState extends StatefulWidget {
  const _wrapperStatefulState({super.key});

  @override
  State<_wrapperStatefulState> createState() => __wrapperStatefulStateState();
}


class __wrapperStatefulStateState extends State<_wrapperStatefulState> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  

  Widget divert() {
    if (loggedin == true){
      return MyHomePage(title: 'Hockey Evaluation App');
    }
    else{
      return Authenticate();
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      loggedin = false;
      print(loggedin.toString());
      divert();
    } else {
      print('User is signed in!');
      print(user.uid);
      loggedin = true;
      print(loggedin.toString());
      divert();
    }
  });
  //need to set this up to listeners.
  return divert();
  }
}