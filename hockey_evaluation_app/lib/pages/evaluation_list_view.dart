import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/pages/new_eval.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';

//TODO: Make sure that list items are spaced properly. For example, the names should be aligned

typedef EvaluationListChangedCallback = Function(Evaluation evaluation);

class EvaluationListView extends StatefulWidget {
  final List items;
  List displayitems = [];
  final EvaluationHighlightedCallback onEvaluationListChanged;

  EvaluationListView(
      {super.key, required this.items, required this.onEvaluationListChanged}) {
    displayitems = items;
  }

  @override
  State<StatefulWidget> createState() {
    return EvaluationListViewState();
  }
}

class EvaluationListViewState extends State<EvaluationListView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  // for searching stuff
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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

  List<Evaluation> _searchEvals(String search) {
    List<Evaluation> searched_evals = [];
    for (Evaluation e in widget.items) {
      if (e.name.toLowerCase().contains(search.toLowerCase())) {
        searched_evals.add(e);
      }
    }
    return searched_evals;
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

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: Text('Search'),
          content: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter Eval name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.displayitems = widget.items;
                });
                _searchController.clear();
              },
              child: Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _searchController.clear();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print(_searchController.text);
                setState(() {
                  widget.displayitems = _searchEvals(_searchController.text);
                });
                print(_searchEvals(_searchController.text));
                _searchController.clear();
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evaluations Page"),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 80, 78, 78),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Pretend this brought up a way to filter')));
              },
              icon: const Icon(Icons.filter_alt_sharp)),
          IconButton(
              onPressed: () {
                showSearchDialog(context);
              },
              icon: const Icon(Icons.search))
        ],
        centerTitle: true,
        //shadowColor: Colors.black,
        bottom: TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 12.0),
          tabs: const [
            Tab(text: "All Evaluations"), // Wrap each Text in a Tab widget
            Tab(text: "Open Evaluations"),
            Tab(text: "Highlighted"),
          ],
          indicatorSize:
              TabBarIndicatorSize.label, // Aligns indicator with label width
          labelPadding: EdgeInsets.symmetric(
              horizontal: 16.0), // Optional: adjusts spacing between tabs
        ),
      ),
      body: //It may be easier to have each tabbarview return a different screen... or maybe just do it all here. I am not sure
          TabBarView(controller: _tabController, children: [
        ListView.builder(
            itemCount: widget.displayitems.length,
            itemBuilder: (BuildContext context, int index) {
              final evaluation = widget.displayitems[index];

              return EvaluationItem(
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
