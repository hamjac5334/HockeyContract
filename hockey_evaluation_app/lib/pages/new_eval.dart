import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/widgets/evaluation_item.dart';
import 'package:hockey_evaluation_app/widgets/widgets.dart';

class NewEval extends StatefulWidget {
  const NewEval({super.key});

  @override
  State<NewEval> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewEval> {
final TextEditingController _goalController = TextEditingController();
final TextEditingController _evalController = TextEditingController();
String valuetext = "+";
String valuetexte = "+";
String selectedDate = "Select Date";
String addinfotext = "Add relevant notes such as teams playing, drills conducted, etc.";
List<DropdownMenuItem<String>> get gameTypeItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Game"),value: "Game"),
    DropdownMenuItem(child: Text("Practice"),value: "Practice"),
    DropdownMenuItem(child: Text("Scrimmage"),value: "Scrimmage"),
  ];
  return menuItems;
}
String selectedvalue = "Game";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('New Evaluation'),
      ),
      body: Column(
        children: [const Paragraph("Select a goaltender"),
        const SizedBox(height: 5),
          Container(
          margin: EdgeInsets.all(10),
          height: 20.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(// text color
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            onPressed: () {
                AlertDialog(title: const Text('Add Goaltender'),
                 content: Column(children: [
                TextField(
                onChanged: (value) {
                 setState(() {
                valuetext = value;
                });
                },
            controller: _goalController,
            decoration: const InputDecoration(hintText: "Name"),),
            ],
            ),
            );
            },
            child: Text(valuetext,
              style: TextStyle(fontSize: 15),
            ),
          ),),
          const SizedBox(height: 10),
          const Paragraph("Select an Evaluator"),
          const SizedBox(height: 5),
          Container(
          margin: EdgeInsets.all(10),
          height: 20.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(// text color
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            onPressed: () {
                AlertDialog(title: const Text('Add Evaluator'),
                 content: Column(children: [
                TextField(
                onChanged: (value) {
                 setState(() {
                valuetexte = value;
                });
                },
            controller: _evalController,
            decoration: const InputDecoration(hintText: "Name"),),
            ],
            ),
            );
            },
            child: Text(valuetexte,
              style: TextStyle(fontSize: 15),
            ),
          ),),
          const SizedBox(height:10),
          const Paragraph("Evaluation Type"),
           DropdownButton(
            value: selectedvalue,
            onChanged: (String? newValue){
            setState(() {
            selectedvalue = newValue!;
            });
            },
            items: gameTypeItems
            ),
            const SizedBox(height:10),
            const Paragraph("Evaluation Date"),
            ElevatedButton(
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
              const SizedBox(height: 10),
              const Paragraph("Additional Notes"),
              Container(
                margin: EdgeInsets.all(10),
                height: 40.0,
                child: TextField(onChanged: (value) {
                 setState(() {
                addinfotext = value;
                });
                },

                ),
              )
        ],
        ),
        floatingActionButton: Row( 
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed:(){} ,
            //go to open eval and add to list with new info
            child: Text("Open Evaluation"),
            ),
        ]

      )
    );

  }
}