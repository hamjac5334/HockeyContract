import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';
import 'package:hockey_evaluation_app/widgets/widgets.dart';
import 'package:hockey_evaluation_app/pages/scoring_page.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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


  void dataSave(){
  var db = FirebaseFirestore.instance;

  //db.collection("Goaltenders").doc(goaltenderName).collection("Evaluations").doc("Evaluation").set({"Name": goaltenderName, "Level/Age": levelAge, "Organization" : organization});
  db.collection("Goaltenders").doc(goalieName).collection("Evaluations").doc(DateTime.now().toString()).set({"Name": goalieName, "Evaluator": evaluatorName, "Evaluation Typle" : evaluationType, "Evaluation Date" : DateTime.now(), "Additional Notes": notes});
  db.collection("Evaluations").doc(goalieName +" - "+ DateTime.now().toString()).set({"Name": goalieName, "Evaluator": evaluatorName, "Evaluation Type" : evaluationType, "Evaluation Date" : DateTime.now(), "Additional Notes": notes});

}


  String selectedvalue = "Game";

  @override
  Widget build(BuildContext context) {
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
                                      goalieName = value;
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
                                    color: Colors.red,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("OK", style: TextStyle(color: Colors.white)),
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
                                     color: Colors.red,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("OK", style: TextStyle(color: Colors.white)),
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
                  notes = value;
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
              dataSave();
              widget.onEvaluationListChanged(Evaluation(
                  goaltender: Goaltender(
                      name: "Temporary fix",
                      levelAge: "21",
                      organization: "HEndrix"),
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
            //uncomment code below for icon
            //child: const Icon(Icons.add),
          ),
        ]));
  }
}
