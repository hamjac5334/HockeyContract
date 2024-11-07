import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(104, 224, 59, 48),
            width: 1), // Red border
        borderRadius:
            BorderRadius.circular(4), // Match Card's corner radius if desired
      ),
      child: Card(
        elevation: 0, // Optional: remove Card's shadow to emphasize the border
        child: ListTile(
          title: Text(goaltender.name),
          leading: Text(goaltender.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(goaltender.levelAge),
              Text(goaltender.organization),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              onGoaltenderWatchlist(goaltender);
            },
            icon: Icon(
              Icons.star,
              color: goaltender.watchlist ? Colors.red : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
