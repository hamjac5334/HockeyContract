import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/widgets/goaltender_item.dart';

typedef GoaltenderListChangedCallback = Function(Goaltender goaltender);

class GoaltenderListView extends StatefulWidget {
  final List items;
  final GoaltenderListChangedCallback onGoaltenderListChanged;
  const GoaltenderListView(
      {super.key, required this.items, required this.onGoaltenderListChanged});

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

  void _handleGoaltenderWatchlistAdded(Goaltender goaltender) {
    setState(() {
      goaltender.toggleWatchlist();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GoalTenders Page"),
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Pretend this brought up a searchbar')));
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
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              final goalie = widget.items[index];

              //return a goalie item
              return GoaltenderItem(
                goaltender: goalie,
                onGoaltenderWatchlist: _handleGoaltenderWatchlistAdded,
              );
            }),
        const Text("I have no clue how to do this"),
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
