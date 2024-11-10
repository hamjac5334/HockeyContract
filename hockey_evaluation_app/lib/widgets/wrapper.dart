import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //return either home or authenticate widget
    return MyHomePage(title: 'Hockey Evaluation App');
  }
}