import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';

class OpenEvaluationInfoPage extends StatelessWidget {
  Evaluation evaluation;
  OpenEvaluationInfoPage({super.key, required this.evaluation});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(evaluation.name),
          bottom: const TabBar(tabs: [
            Text("Evaluation Info"),
            Text("Scoring"),
            Text("Comments"),
            Text("Submit")
          ]),
        ),
        body: const TabBarView(children: [
          Text("Return evaluation info page"),
          Text("Return Jack's Scoring page"),
          Text("Return Comments Page"),
          Text("Return submit page")
        ]),
      ),
    );
  }
}
