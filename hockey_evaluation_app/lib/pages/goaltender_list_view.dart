import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goalie.dart';
import 'package:hockey_evaluation_app/widgets/goalie_item.dart';

class GoaltenderListView extends StatefulWidget {
  final List items;
  const GoaltenderListView({super.key, required this.items});

  @override
  State<StatefulWidget> createState() {
    return GoaltenderListViewState();
  }
}

class GoaltenderListViewState extends State<GoaltenderListView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GoalTenders Page"),
          actions: [
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Pretend this brought up a way to filter')));
                },
                icon: const Icon(Icons.filter_alt_sharp)),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Pretend this brought up a searchbar')));
                },
                icon: const Icon(Icons.search))
          ],
          centerTitle: true,
          bottom: TabBar(
              labelColor: Colors.black,
              controller: _tabController,
              tabs: const [
                Text("All Goaltenders"),
                Text("Comparisons"),
                Text("Watchlist")
              ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final goalie = widget.items[index];

                //return a goalie item
                return GoalieItem(goalie: goalie);
              }),
          const Text("I have no clue how to do this"),
          const Text("Ill get this later")
        ]));
  }
}
