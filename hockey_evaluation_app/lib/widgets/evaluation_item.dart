import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(104, 224, 59, 48),
            width: 1), // Add red border
        borderRadius:
            BorderRadius.circular(4), // Optional: match Card's corner radius
      ),
      child: Card(
        elevation:
            0, // Optional: remove Card's default shadow to highlight the border
        child: ListTile(
          title: Text(evaluation.name),
          leading: Text(evaluation.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(evaluation.evaluationType),
              Text(DateFormat('yyyy-MM-dd').format(evaluation.evaluationDate)),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              onEvaluationHighlighted(evaluation);
            },
            icon: Icon(
              Icons.star,
              color: evaluation.highlighted
                  ? const Color.fromARGB(255, 141, 40, 33)
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
