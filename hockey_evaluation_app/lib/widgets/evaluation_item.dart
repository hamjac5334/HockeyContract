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
        subtitle: Text(evaluation.evaluationType),
        trailing: IconButton(
            onPressed: () {
              onEvaluationHighlighted(evaluation);
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: Text(
              //         'Pretend there was some kind of animation and this was now on the highlighted list')));
            },
            icon: const Icon(Icons.star)),
      ),
    );
    // return SizedBox(
    //   child: Container(
    //     constraints: const BoxConstraints(maxWidth: 50, maxHeight: 200),
    //     alignment: Alignment.centerLeft,
    //     margin: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(
    //         border: Border.all(color: Colors.black), color: Colors.red),
    //     child: Column(
    //       children: [
    //         Text(evaluation.name),
    //         Text(DateFormat('MM-dd-yy').format(evaluation.evaluationDate)),
    //         Text(evaluation.evaluationType),
    //       ],
    //     ),
    //   ),
    // );
  }
}
