import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goalie.dart';

class GoalieItem extends StatelessWidget {
  const GoalieItem({super.key, required this.goalie});

  final Goalie goalie;
  @override
  Widget build(BuildContext context) {
    return const Card(
        child: ListTile(
      title: Text("This is where the name goes"),
      leading: Text("Name"),
      subtitle: Text("Subtitle information"),
      trailing: Icon(Icons.star),
    ));
  }
}
