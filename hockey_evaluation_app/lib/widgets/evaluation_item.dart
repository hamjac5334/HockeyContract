import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/open_evaluation_info_page.dart';
import 'package:intl/intl.dart';

typedef EvaluationHighlightedCallback = Function(Evaluation evaluation);

class EvaluationItem extends StatelessWidget {
  const EvaluationItem(
      {super.key,
      required this.evaluation,
      required this.onEvaluationHighlighted,
      required this.goaltenders});

  final EvaluationHighlightedCallback onEvaluationHighlighted;

  final Evaluation evaluation;
  final List<Goaltender> goaltenders;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(104, 224, 59, 48),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100, // Adjust width as needed
              maxWidth: 100, // Ensures the left section does not overflow
            ),
            child: Text(
              evaluation.goaltender.name,
              overflow: TextOverflow.ellipsis, // Truncate text if too long
            ),
          ),
          title: Text(evaluation.goaltender.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(evaluation.evaluationType),
              Text(DateFormat('yyyy-MM-dd').format(evaluation.evaluationDate)),
            ],
          ),
          onTap: () {
            if (!evaluation.completed) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OpenEvaluationInfoPage(
                        evaluation: evaluation,
                        goaltenders: goaltenders,
                      )));
            }
          },
          trailing: IconButton(
            onPressed: () {
              onEvaluationHighlighted(evaluation);
            },
            icon: evaluation.highlighted
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
            color: const Color.fromARGB(255, 141, 40, 33),
          ),
        ),
      ),
    );
  }
}
