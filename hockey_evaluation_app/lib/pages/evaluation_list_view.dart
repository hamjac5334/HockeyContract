import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/new_eval.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';

//TODO: Make sure that list items are spaced properly. For example, the names should be aligned

typedef EvaluationListChangedCallback = Function(Evaluation evaluation);

class EvaluationListView extends StatefulWidget {
  final List items;
  final EvaluationHighlightedCallback onEvaluationListChanged;
  final List<Goaltender> goaltenders;

  const EvaluationListView(
      {super.key,
      required this.items,
      required this.onEvaluationListChanged,
      required this.goaltenders});

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

  void _handleEvaluationHighlighted(Evaluation evaluation) {
    setState(() {
      evaluation.set_highlighted();
    });
  }

  List<Evaluation> getOpenEvaluationsList() {
    List<Evaluation> evals = [];
    for (Evaluation e in widget.items) {
      if (!e.completed) {
        evals.add(e);
      }
    }
    return evals;
  }

  List<Evaluation> getHighlightedEvaluationsList() {
    List<Evaluation> evals = [];
    for (Evaluation evaluation in widget.items) {
      if (evaluation.highlighted) {
        evals.add(evaluation);
      }
    }
    return evals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evaluations Page"),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Pretend this brought up a way to filter')));
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
              Text("All Evaluations"),
              Text("Open Evaluations"),
              Text("Highlighted")
            ]),
      ),
      body: //It may be easier to have each tabbarview return a different screen... or maybe just do it all here. I am not sure
          TabBarView(controller: _tabController, children: [
        ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              final evaluation = widget.items[index];

              return EvaluationItem(
                goaltenders: widget.goaltenders,
                evaluation: evaluation,
                onEvaluationHighlighted: _handleEvaluationHighlighted,
              );
            }),
        ListView.builder(
            //This is a temporary solution, but I guess this works. It is ugly but it does the job.
            itemCount: getOpenEvaluationsList().length,
            itemBuilder: (BuildContext context, int index) {
              List<Evaluation> lst = getOpenEvaluationsList();

              if (index < lst.length) {
                final evaluation = lst[index];

                return EvaluationItem(
                  goaltenders: widget.goaltenders,
                  evaluation: evaluation,
                  onEvaluationHighlighted: _handleEvaluationHighlighted,
                );
              } else {
                return const Text("Something is Wrong!!!");
              }
            }),
        ListView.builder(
            itemCount: getHighlightedEvaluationsList().length,
            itemBuilder: (BuildContext context, int index) {
              List<Evaluation> lst = getHighlightedEvaluationsList();

              final evaluation = lst[index];
              return EvaluationItem(
                goaltenders: widget.goaltenders,
                evaluation: evaluation,
                onEvaluationHighlighted: _handleEvaluationHighlighted,
              );
            })
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewEval(
                  onEvaluationListChanged: widget.onEvaluationListChanged,
                ),
              ),
            );
          },
          child: const Text('Add Eval')
          //pull up the add new evaluation page.
          /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Pretend this goes to the create evaluation page")));*/
          ),
    );
  }
}
