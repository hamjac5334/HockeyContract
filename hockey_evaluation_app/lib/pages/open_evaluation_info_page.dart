import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/pages/scoring_page.dart';
import 'package:hockey_evaluation_app/widgets/goaltender_item.dart';

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
        body: TabBarView(children: [
          Text("Return Info page"),
          EvaluationUI(),
          Column(
            children: [
              TextField(
                minLines: 10,
                maxLines: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    print("Pretent this saved the comment");
                  },
                  child: const Text("Save comment"))
            ],
          ),
          Column(
            children: [
              Text("Review Evaluation"),
              Text("Pretend there is a table here"),
              ElevatedButton(
                  onPressed: () {
                    print("Pretend this submitted and closed the evaluation");
                  },
                  child: Text("Submit"))
            ],
          )
        ]),
      ),
    );
  }
}
