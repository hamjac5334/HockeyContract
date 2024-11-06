import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:intl/intl.dart';

typedef EvaluationHighlightedCallback = Function(Evaluation evaluation);

class EvaluationItem extends StatelessWidget {
  const EvaluationItem(
      {super.key,
      required this.evaluation,
      required this.onEvaluationHighlighted});

  final EvaluationHighlightedCallback onEvaluationHighlighted;

  final Evaluation evaluation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(evaluation.name),
        leading: Text(evaluation.name),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(evaluation.evaluationType),
          Text(DateFormat('yyyy-MM-dd').format(evaluation.evaluationDate))
        ]),
        trailing: IconButton(
            onPressed: () {
              onEvaluationHighlighted(evaluation);
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: Text(
              //         'Pretend there was some kind of animation and this was now on the highlighted list')));
            },
            icon: Icon(
              Icons.star,
              color: evaluation.highlighted ? Colors.yellow : Colors.black,
            )),
      ),
    );
  }
}
