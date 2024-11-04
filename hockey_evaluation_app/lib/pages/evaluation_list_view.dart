import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
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

  List<Evaluation> getEvaluationList() {
    List<Evaluation> evals = [];
    for (Evaluation e in widget.items) {
      if (e.completed) {
        evals.add(e);
      }
    }
    return evals;
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
        bottom: TabBar(
            labelColor: Colors.black,
            controller: _tabController,
            tabs: const [
              Text("Open Evaluations"),
              Text("All Evaluations"),
              Text("Highlighted")
            ]),
      ),
      body: //It may be easier to have each tabbarview return a different screen... or maybe just do it all here. I am not sure
          TabBarView(controller: _tabController, children: [
        ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              final evaluation = widget.items[index];

              return EvaluationItem(evaluation: evaluation);
            }),
        ListView.builder(
            //This is a temporary solution, but I guess this works. It is ugly but it does the job.
            itemCount: getEvaluationList().length,
            itemBuilder: (BuildContext context, int index) {
              List<Evaluation> lst = getEvaluationList();

              if (index < lst.length) {
                final evaluation = lst[index];

                return EvaluationItem(evaluation: evaluation);
              } else {
                return const Text("Something is Wrong!!!");
              }
            }),
        Text("Howdy")
      ]),
    );
  }
}
