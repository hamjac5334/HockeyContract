import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/widgets/goaltender_item.dart';

typedef GoaltenderListChangedCallback = Function(Goaltender goaltender);

class GoaltenderListView extends StatefulWidget {
  final List items;
  List displayitems = [];
  final GoaltenderListChangedCallback onGoaltenderListChanged;
  GoaltenderListView(
      {super.key, required this.items, required this.onGoaltenderListChanged}) {
    displayitems = items;
  }

  @override
  State<StatefulWidget> createState() {
    return GoaltenderListViewState();
  }
}

class GoaltenderListViewState extends State<GoaltenderListView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _filterController = TextEditingController();
  final List<String> _filters = ["A-Z", "Z-A"];

  String? _selectedFilter;

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

  List<Goaltender> _searchEvals(String search) {
    List<Goaltender> searched_evals = [];
    for (Goaltender g in widget.items) {
      if (g.name.toLowerCase().contains(search.toLowerCase())) {
        searched_evals.add(g);
      }
    }
    return searched_evals;
  }

  void _handleGoaltenderWatchlistAdded(Goaltender goaltender) {
    setState(() {
      goaltender.toggleWatchlist();
    });
  }
   void _filtergoalies(String? filter) {
    if (filter == "A-Z") {
      widget.displayitems.sort((a, b) => a.toString().compareTo(b.toString()));
    } else if (filter == 'Z-A') {
      widget.displayitems.sort((b, a) => a.toString().compareTo(b.toString()));
    } 
  }

  List<Goaltender> getGoaltenderWatchList() {
    List<Goaltender> watchlist_goaltenders = [];
    for (Goaltender goaltender in widget.items) {
      if (goaltender.watchlist) {
        watchlist_goaltenders.add(goaltender);
      }
    }
    return watchlist_goaltenders;
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: Text('Filter'),
          content: TextField(
            controller: _filterController,
            decoration: InputDecoration(
              hintText: 'Enter Goaltender',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.displayitems = widget.items;
                });
                _filterController.clear();
              },
              child: Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _filterController.clear();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.displayitems = _searchEvals(_filterController.text);
                });
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: Text('Filter'),
          content: DropdownButton<String>(
            value: _selectedFilter,
            onChanged: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            hint: const Center(
                child: Text(
              'Select Filter',
              style: TextStyle(color: Colors.grey),
            
            )),
            // Hide the default underline
            underline: Container(),
            // set the color of the dropdown menu
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.grey,
            ),
            isExpanded: true,

            // The list of options
            items: _filters
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.displayitems = widget.items;
                  _selectedFilter = null;
                });
              },
              child: Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  _filtergoalies(_selectedFilter);
                });
              },
              child: Text('Filter'),
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
        title: const Text("Goaltenders Page"),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 80, 78, 78),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showFilterDialog(context);
              },
              icon: const Icon(Icons.filter_alt_sharp)),
          IconButton(
              onPressed: () {
                showSearchDialog(context);
              },
              icon: const Icon(Icons.search))
        ],
        centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 12.0),
          tabs: const [
            Tab(text: "All Goaltenders"), // Wrap each Text in a Tab widget
            Tab(text: "Comparisons"),
            Tab(text: "Watchlist"),
          ],
          indicatorSize: TabBarIndicatorSize
              .label, // Aligns the indicator with each label's width
          labelPadding: EdgeInsets.symmetric(
              horizontal: 16.0), // Optional: adjust spacing between tabs
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        ListView.builder(
            itemCount: widget.displayitems.length,
            itemBuilder: (BuildContext context, int index) {
              final goalie = widget.displayitems[index];

              //return a goalie item
              return GoaltenderItem(
                goaltender: goalie,
                onGoaltenderWatchlist: _handleGoaltenderWatchlistAdded,
              );
            }),
        const Text("Waiting for firebase data to be properly stored"),
        ListView.builder(
            itemCount: getGoaltenderWatchList().length,
            itemBuilder: (BuildContext context, int index) {
              List<Goaltender> lst = getGoaltenderWatchList();

              final goaltender = lst[index];

              return GoaltenderItem(
                  goaltender: goaltender,
                  onGoaltenderWatchlist: _handleGoaltenderWatchlistAdded);
            })
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewGoaltenderPage(
                    onGoaltenderListChanged: widget.onGoaltenderListChanged,
                  )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
