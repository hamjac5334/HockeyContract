import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/score_list.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hockey_evaluation_app/main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

//put in a main function to run page individually
void main() {
  runApp(MaterialApp(
    theme: appTheme,
    home: EvaluationUI(),
  ));
}

class EvaluationUI extends StatelessWidget {
  const EvaluationUI({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(21), children: [
      Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Calculate Scores"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 207, 174, 221),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      SizedBox(height: 22),

      //Only put values in for Run bc I don't know the other features
      EvaluationCategory(
          title: "See", subItems: ["Acquisition", "Tracking", "Focus"]),

      EvaluationCategory(
          title: "Understand",
          subItems: ["Play Reading", "Pattern Recognition", "Awareness"]),
      EvaluationCategory(
          title: "Drive",
          subItems: ["Compete Level", "Motivation", "Confidence"]),
      EvaluationCategory(
          title: "Adapt",
          subItems: ["Creativity", "Save Selection", "Playmaking"]),
      EvaluationCategory(
          title: "Move",
          subItems: ["Energy", "Skating", "Range", "Coordination"]),
      EvaluationCategory(
          title: "Save",
          subItems: ["Positioning", "Stance", "Rebound Control"]),
      EvaluationCategory(
          title: "Learn",
          subItems: ["Team Orientation", "Work Ethic", "Maturity"]),
      EvaluationCategory(
          title: "Grow",
          subItems: ["Athletic Habits", "Emotional Habits", "Practice Habits"]),
    ]);
  }
}

class EvaluationCategory extends StatefulWidget {
  final String title;
  final List<String> subItems;

  const EvaluationCategory({
    Key? key,
    required this.title,
    this.subItems = const [],
  }) : super(key: key);

  @override
  _EvaluationCategoryState createState() => _EvaluationCategoryState();
}

class _EvaluationCategoryState extends State<EvaluationCategory> {
  bool isExpanded = false;

  // Map to hold ScoreList instances for each subItem
  final Map<String, ScoreList> subItemCounters = {};

  //controls the dropdown items
  @override
  void initState() {
    super.initState();
    for (var item in widget.subItems) {
      subItemCounters[item] = ScoreList(name: item);
    }
  }

  //dropdown menu: https://www.youtube.com/watch?v=6_Azs3fq9O4
  //https://api.flutter.dev/flutter/material/DropdownMenu-class.html
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          trailing: Icon(
            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
        if (isExpanded && widget.subItems.isNotEmpty)
          Column(
            children: widget.subItems.map((subItem) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(subItem),
                        SizedBox(width: 8),
                        Text(
                          '${subItemCounters[subItem]?.count ?? 0}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              subItemCounters[subItem]?.decrease();
                            });
                          },
                        ),
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              subItemCounters[subItem]?.increase();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
