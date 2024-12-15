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
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: 100,
            ),
            child: Text(
              goaltender.name,
              overflow: TextOverflow.ellipsis, // Truncate text if too long
            ),
          ),
          title: Text(goaltender.name),
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
            icon: goaltender.watchlist
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
            color: const Color.fromARGB(255, 141, 40, 33),
          ),
        ),
      ),
    );
  }
}
