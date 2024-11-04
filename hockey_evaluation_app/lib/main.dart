import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goalie.dart';
import 'package:hockey_evaluation_app/pages/evaluation_list_view.dart';
import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hockey Evaluation App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Hockey Evaluation App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int current_screen_index = 0;
  List<Evaluation> evaluations = [
    Evaluation(
        name: "Colten Berry",
        evaluationDate: DateTime.now(),
        evaluationType: "Epic"),
    Evaluation(
        name: "Jack Hamilton",
        evaluationDate: DateTime.now(),
        evaluationType: "Pretty Cool"),
    Evaluation(
        name: "Sam LastName",
        evaluationDate: DateTime.now(),
        evaluationType: "I guess he's alright")
  ];

  List<Goalie> goalies = [
    Goalie(name: "Colten Berry"),
    Goalie(name: "JAck"),
    Goalie(name: "Sarah")
  ];

  @override
  void initState() {
    super.initState();
    Evaluation e = Evaluation(
        name: "Closed Evaluation 1",
        evaluationDate: DateTime.now(),
        evaluationType: "Howdy");

    e.set_completed();

    evaluations.add(e);

    e = Evaluation(
        name: "Closed Evaluation 2",
        evaluationDate: DateTime.now(),
        evaluationType: "evaluationType");
    e.set_completed();
    evaluations.add(e);
  }

  Widget returnScreen() {
    if (current_screen_index == 0) {
      //return the page.
      return EvaluationListView(items: evaluations);
    } else if (current_screen_index == 1) {
      return GoaltenderListView(items: goalies);
    } else {
      return EvaluationListView(items: evaluations);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text("Home"),
                onTap: () {
                  print("tapped");
                  current_screen_index = 0;
                },
              ),
              ListTile(
                title: const Text("Goaltenders"),
                onTap: () {
                  setState(() {
                    current_screen_index = 1;
                  });
                },
              ),
              ListTile(
                title: Text("Evaluations"),
                onTap: () {
                  print("Pretend this opened the evaluations page");
                },
              ),
              ListTile(
                title: Text("Notifications"),
                onTap: () {
                  print("Pretend this opened a notifications page");
                },
              ),
              ListTile(
                title: Text("Orginization"),
                onTap: () {
                  print("Pretend this opened an organization page");
                },
              ),
              ListTile(
                title: Text("Account"),
                onTap: () {
                  print("Pretend this opened an accout page");
                },
              ),
              ListTile(
                title: Text("Settings"),
                onTap: () {
                  print("Pretend this opened a settings page");
                },
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () {
                  print("Pretend this opened the logout page");
                },
              )
            ],
          ),
        ),
        body: returnScreen()
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        );
  }
}
