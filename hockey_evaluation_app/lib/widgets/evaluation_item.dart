import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:intl/intl.dart';

//change from listtile to box
class EvaluationItem extends StatelessWidget {
  const EvaluationItem({super.key, required this.evaluation});

  final Evaluation evaluation;

  @override
  Widget build(BuildContext context) {
    // Format the date to a readable format (e.g., "Jan 1, 2024")
    String formattedDate = DateFormat.yMMMd().format(evaluation.evaluationDate);

    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            evaluation.name,
          ),
          SizedBox(height: 4.0),
          Text(
            'Date: $formattedDate',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            evaluation.evaluationType,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.0,
            ),
          ),
          // if (evaluation.completed)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 4.0),
          //     child: Text(
          //       'Completed',
          //       style: TextStyle(
          //         color: Colors.green,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 14.0,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
