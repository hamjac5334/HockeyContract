import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/item_score.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';

//TODO: I can just combine this and evaluation category on scoring_page.

class CategoryScore extends StatefulWidget {
  final String name;
  final List<ItemScore> itemScores;
  const CategoryScore(
      {super.key, required this.name, required this.itemScores});

  @override
  State<StatefulWidget> createState() {
    return CategoryScoreState();
  }

  int getItemScore(String item){
    for (ItemScore itemScore in itemScores){
      if (item == itemScore.name){
        return itemScore.count;
      }
    }
    return 0;
  }

  double getAverage() {
    int denominator = 0;
    int numerator = 0;
    for (ItemScore itemScore in itemScores) {
      numerator += itemScore.count * 2;
      denominator += 2;
    }
    return numerator / denominator;
  }
}



class CategoryScoreState extends State<CategoryScore> {
  double averageScore = 0.0;
  bool isExpanded = false;

  void averageScores() {
    int total = 0;
    for (ItemScore item in widget.itemScores) {
      total += item.count;
    }
    averageScore = total / widget.itemScores.length;
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Header(widget.name),
          trailing: Icon(
            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
        if (isExpanded && widget.itemScores.isNotEmpty)
          Column(
            children: widget.itemScores.map((subItem) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Paragraph(subItem.name),
                        SizedBox(width: 8),
                        Text(
                          '${subItem.count}',
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
                              subItem.decrease();
                              averageScores();
                              print("Average Score: $averageScore");
                            });
                          },
                        ),
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              subItem.increase();
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
