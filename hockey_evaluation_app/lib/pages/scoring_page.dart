import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/score_list.dart';

//put in a main function to run page individually
void main() {
  runApp(const MaterialApp(
    home: EvaluationUI(),
  ));
}

class EvaluationUI extends StatelessWidget {
  const EvaluationUI({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(21),
      children: [
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
            title: "See",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),

        EvaluationCategory(
            title: "Understand",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),
        EvaluationCategory(
            title: "Drive",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),
        EvaluationCategory(
            title: "Adapt",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),
        EvaluationCategory(
            title: "Move",
            subItems: ["Energy", "Skating", "Range", "Coordination"]),
        EvaluationCategory(
            title: "Save",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),
        EvaluationCategory(
            title: "Learn",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),
        EvaluationCategory(
            title: "Grow",
            subItems: ["Example1", "Example2", "Example3", "Example4"]),
      ],
    );
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
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              subItemCounters[subItem]?.decrease();
                            });
                          },
                        ),
                        IconButton(
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
