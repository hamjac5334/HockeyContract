import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';

typedef GoaltenderWatchlistCallback = Function(Goaltender goaltender);

class GoaltenderItem extends StatelessWidget {
  const GoaltenderItem(
      {super.key,
      required this.goaltender,
      required this.onGoaltenderWatchlist});

  final Goaltender goaltender;
  final GoaltenderWatchlistCallback onGoaltenderWatchlist;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(goaltender.name),
            leading: Text(goaltender.name),
            subtitle: const Text("Subtitle information"),
            trailing: IconButton(
                onPressed: () {
                  onGoaltenderWatchlist(goaltender);
                },
                icon: Icon(
                  Icons.star,
                  color: goaltender.watchlist ? Colors.yellow : Colors.black,
                ))));
  }
}
