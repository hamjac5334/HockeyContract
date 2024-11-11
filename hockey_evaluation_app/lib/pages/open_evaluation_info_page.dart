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
          Column(
            children: [
              Text("GoalTender: "),
              Text("Evaluation Type: "),
              Text("Evaluation Date: "),
              Text("Additional Notes: "),
            ],
          ),
          EvaluationUI(),
          OpenEvaluationCommentsPage(evaluation: evaluation),
          Column(
            children: [
              Text("Review Evaluation"),
              Text("Pretend there is a table here"),
            ],
          )
        ]),
      ),
    );
  }
}

class OpenEvaluationCommentsPage extends StatelessWidget {
  Evaluation evaluation;

  OpenEvaluationCommentsPage({super.key, required this.evaluation});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = evaluation.comments; // initialize the text
    return Column(
      children: [
        TextField(
          controller: _controller,
          minLines: 10,
          maxLines: 10,
        ),
        ElevatedButton(
            onPressed: () {
              evaluation.comments = _controller.text;
              print(evaluation.comments);
            },
            child: const Text("Save comment")),
      ],
    );
  }
}
