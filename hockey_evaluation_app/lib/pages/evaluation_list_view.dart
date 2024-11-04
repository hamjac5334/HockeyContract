import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';

class EvaluationListView extends StatefulWidget {
  final List items;

  const EvaluationListView({super.key, required this.items});

  @override
  State<StatefulWidget> createState() {
    return EvaluationListViewState();
  }
}

class EvaluationListViewState extends State<EvaluationListView>
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
          title: const Text("Goalie Evaluation"),
          actions: [
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
                icon: const Icon(Icons.filter_alt_sharp)),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
                icon: const Icon(Icons.search))
          ],
          centerTitle: true,
          bottom: TabBar(controller: _tabController, tabs: const [
            Text("Open Evaluations"),
            Text("All Evaluations"),
            Text("Highlighted")
          ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final evaluation = widget.items[index];

                return EvaluationItem(evaluation: evaluation);
              }),
          Text("HEy"),
          Text("Howdy")
        ]));
  }
}
