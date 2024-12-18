import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/full_score.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';
import 'package:hockey_evaluation_app/widgets/widgets.dart';
import 'package:hockey_evaluation_app/pages/scoring_page.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

typedef EvaluationListChangedCallback = Function(Evaluation evaluation);

class NewEval extends StatefulWidget {
  EvaluationHighlightedCallback onEvaluationListChanged;
  final List<Goaltender> goaltenders;

  NewEval(
      {super.key,
      required this.goaltenders,
      required this.onEvaluationListChanged});

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
      DropdownMenuItem(child: Text("Game/Scrimmage"), value: "Game"),
      DropdownMenuItem(child: Text("Practice"), value: "Practice"),
      //DropdownMenuItem(child: Text("Scrimmage"), value: "Scrimmage"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }

  String goalieName = "";
  String evaluatorName = "";
  String evaluationType = "Game";
  String notes = "";
  late Goaltender? selectedGoaltender;
  String organization = "";

  void _cloudOrgPull() async {
    var db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    await db.collection("Users").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ('${docSnapshot.id} => ${docSnapshot.data()}');
          if (auth.currentUser?.email == docSnapshot.id) {
            organization = docSnapshot.data()["Organization"];
            
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
}

  void dataSave() {
    var db = FirebaseFirestore.instance;
    db
        .collection("Goaltenders")
        .doc(goalieName + organization)
        .collection("Evaluations")
        .doc(DateTime.now().toString().substring(0, 19))
        .set({
      "Name": goalieName,
      "Evaluator": evaluatorName,
      "Evaluation Type": evaluationType,
      "Evaluation Date": DateTime.now(),
      "Additional Notes": notes,
      "Completed": false
    });
  }

  String selectedvalue = "Game";

  @override
  Widget build(BuildContext context) {
    _cloudOrgPull();
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Evaluations"),
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 80, 78, 78),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Paragraph("Select a goaltender"),
            const SizedBox(height: 5),

            //This is the old way of picking a goaltender, it did not use a drop down list but it looked nice so i just commented it out

            // Container(
            //   margin: EdgeInsets.all(1),
            //   height: 40.0,
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       // text color
            //       padding: EdgeInsets.all(5),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(0.0),
            //       ),
            //     ),
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (ctx) => AlertDialog(
            //                   title: const Text('Add Goaltender'),
            //                   content: Column(
            //                     children: [
            //                       TextField(
            //                         onChanged: (value) {
            //                           goalieName = value;
            //                           setState(() {
            //                             valuetext = value;
            //                           });
            //                         },
            //                         controller: _goalController,
            //                         decoration:
            //                             const InputDecoration(hintText: "Name"),
            //                       ),
            //                     ],
            //                   ),
            //                   actions: <Widget>[
            //                     TextButton(
            //                       onPressed: () {
            //                         Navigator.of(ctx).pop();
            //                       },
            //                       child: Container(
            //                         color: Colors.red,
            //                         padding: const EdgeInsets.all(14),
            //                         child: const Text("OK",
            //                             style: TextStyle(color: Colors.white)),
            //                       ),
            //                     )
            //                   ]));
            //     },
            //     child: Text(
            //       valuetext,
            //       style: TextStyle(fontSize: 15),
            //     ),
            //   ),
            // ),

            Container(
              width: double.infinity,
              child: DropdownMenu<Goaltender>(
                  width: double.infinity,
                  enableSearch: true,
                  enableFilter: false,
                  requestFocusOnTap: true,
                  onSelected: (Goaltender? goaltender) {
                    setState(() {
                      selectedGoaltender = goaltender;
                    });
                  },
                  dropdownMenuEntries:
                      widget.goaltenders.map((Goaltender goaltender) {
                    return DropdownMenuEntry(
                        value: goaltender, label: goaltender.name);
                  }).toList()),
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    onChanged: (value) {
                                      evaluatorName = value;
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
                                    color: Color. fromARGB(255, 122, 10, 10),
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("OK",
                                        style: TextStyle(color: Colors.white)),
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
                  evaluationType = newValue.toString();
                  setState(() {
                    selectedvalue = newValue!;
                  });
                },
                items: gameTypeItems,
                style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 122, 10, 10)),
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
                  notes = value;
                  setState(() {
                    addinfotext = value;
                  });
                },
                style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 122, 10, 10)),
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
              goalieName = selectedGoaltender!.name;

              dataSave();
              widget.onEvaluationListChanged(Evaluation(
                  goaltender: Goaltender(
                      name: goalieName,
                      levelAge: "21",
                      organization: "Hendrix"),
                  evaluationDate: DateTime.now(),
                  evaluationType: evaluationType,
                  fullScore: FullScore()));
              //Hopefully this fixes the error

              Navigator.pop(context);
            },
            //go to open eval and add to list with new info
            child: Icon(Icons.add),
            hoverColor: Color.fromARGB(255, 122, 10, 10),
        backgroundColor: Color.fromARGB(255, 122, 10, 10),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
          ),
        ]));
  }
}
