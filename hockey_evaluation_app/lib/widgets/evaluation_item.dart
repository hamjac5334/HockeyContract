import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:intl/intl.dart';

class EvaluationItem extends StatelessWidget {
  const EvaluationItem({super.key, required this.evaluation});

  final Evaluation evaluation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(evaluation.name),
      leading: Text(evaluation.name),
      subtitle: Text(evaluation.evaluationType),
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
