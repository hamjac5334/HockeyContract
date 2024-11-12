import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';
import 'package:hockey_evaluation_app/widgets/widgets.dart';
import 'package:hockey_evaluation_app/pages/scoring_page.dart';
import 'package:hockey_evaluation_app/main.dart';

import 'package:firebase_auth/firebase_auth.dart'; 

typedef EvaluationListChangedCallback = Function(Evaluation evaluation);

class NewEval extends StatefulWidget {
  EvaluationHighlightedCallback onEvaluationListChanged;

  NewEval({super.key, required this.onEvaluationListChanged});

  @override
  State<NewEval> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewEval> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _evalController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int current_screen_index = 0;
  String valuetext = "+";
  String evaltext = "+";
  String selectedDate = "Select Date";
  String addinfotext =
      "Add relevant notes such as teams playing, drills conducted, etc.";
  List<DropdownMenuItem<String>> get gameTypeItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Game"), value: "Game"),
      DropdownMenuItem(child: Text("Practice"), value: "Practice"),
      DropdownMenuItem(child: Text("Scrimmage"), value: "Scrimmage"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }

  String selectedvalue = "Game";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //made background of appbar white
          backgroundColor: Colors.white,
          title: Row(
            children: [
              // Add spacing between image and title
              Flexible(
                // This prevents the overflow
                child: Text(
                  "Hockey Evaluation App",
                  style: Theme.of(context).textTheme.labelLarge,
                  //overflow: TextOverflow
                  //   .ellipsis, // Adds ellipsis if text is too long
                ),
              ),
              SizedBox(width: 14),
              Image.asset(
                'lib/image/logo.png', // Path to image file
                height: 40, // Adjust height as needed
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Text(
                  "Home",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("tapped");
                  current_screen_index = 0;
                  //takes you home
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyApp()), 
                    (Route<dynamic> route) => false, 
                  );
                },
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text(
                  "Goaltenders",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() {
                    current_screen_index = 1;
                  });
                },
                leading: const Icon(Icons.people),
              ),
              ListTile(
                title: Text(
                  "Evaluations",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() {
                    current_screen_index = 0;
                  });
                },
                leading: const Icon(Icons.note),
              ),
              ListTile(
                title: Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("Pretend this opened a notifications page");
                },
                leading: const Icon(Icons.notifications),
              ),
              ListTile(
                title: Text(
                  "Organization",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("Pretend this opened an organization page");
                },
                leading: const Icon(Icons.roofing),
              ),
              
              ListTile(
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("Pretend this opened a settings page");
                },
                leading: const Icon(Icons.settings),
              ),
              ListTile(
                title: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () async {
                  await _auth.signOut();
                  print("This should log out");
                },
                leading: const Icon(Icons.logout),
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Paragraph("Select a goaltender"),
            const SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(1),
              height: 40.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // text color
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                              title: const Text('Add Goaltender'),
                              content: Column(
                                children: [
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        valuetext = value;
                                      });
                                    },
                                    controller: _goalController,
                                    decoration:
                                        const InputDecoration(hintText: "Name"),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Colors.green,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("OK"),
                                  ),
                                )
                              ]));
                },
                child: Text(
                  valuetext,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Paragraph("Select an Evaluator"),
            const SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(1),
              height: 40.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // text color
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                              title: const Text('Add Evaluator'),
                              content: Column(
                                children: [
                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        evaltext = value;
                                      });
                                    },
                                    controller: _evalController,
                                    decoration:
                                        const InputDecoration(hintText: "Name"),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("OK"),
                                  ),
                                )
                              ]));
                },
                child: Text(
                  evaltext,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Paragraph("Evaluation Type"),
            Center(
              child: DropdownButton(
                value: selectedvalue,
                menuWidth: double.infinity,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedvalue = newValue!;
                  });
                },
                items: gameTypeItems,
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
            const SizedBox(height: 10),
            const Paragraph("Evaluation Date"),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = '${date.month}/${date.day}/${date.year}';
                    });
                  }
                },
                child: Text(selectedDate),
              ),
            ),
            const SizedBox(height: 10),
            const Paragraph("Additional Notes"),
            Container(
              margin: EdgeInsets.all(10),
              height: (80),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    addinfotext = value;
                  });
                },
                style: TextStyle(fontSize: 13, color: Colors.red),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: () {
              widget.onEvaluationListChanged(Evaluation(
                  name: valuetext,
                  evaluationDate: DateTime.now(),
                  evaluationType: evaltext));
              //change this to navigate to scoring page
              //Navigator.pop(context);
              Navigator.push(
          context,
          MaterialPageRoute(
            //keep this temp and then replace with open form
            builder: (context) => EvaluationUI(), 
          ),
        );
            },
            //go to open eval and add to list with new info
            child: Text("Open Evaluation"),
          ),
        ]));
  }
}
