import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/full_score.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/objects/item_score.dart';
import 'package:hockey_evaluation_app/pages/new_eval.dart';
import 'package:hockey_evaluation_app/pages/scoring_page.dart';
import 'package:hockey_evaluation_app/widgets/goaltender_item.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_evaluation_app/objects/category_score.dart';

class OpenEvaluationInfoPage extends StatelessWidget {
  Evaluation evaluation;

  final List<Goaltender> goaltenders;
  OpenEvaluationInfoPage(
      {super.key, required this.evaluation, required this.goaltenders});
  @override
  Widget build(BuildContext context) {
    print("Goaltender: ${evaluation.goaltender}");
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            evaluation.goaltender.name,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: const TabBar(tabs: [
            AutoSizeText("Info", maxLines: 1),
            AutoSizeText("Scoring", maxLines: 1),
            AutoSizeText("Comments", maxLines: 1),
            AutoSizeText("Submit", maxLines: 1)
          ]),
        ),
        body: TabBarView(children: [
          OpenEvaluationEvaluationInfoPage(
            evaluation: evaluation,
            goaltenders: goaltenders,
          ),
          //change this to be a actual widget
          EvaluationUI(
            fullScore: evaluation.fullScore,
          ),
          OpenEvaluationCommentsPage(evaluation: evaluation),
          OpenEvaluationSubmitPage(evaluation: evaluation)
        ]),
      ),
    );
  }
}

class OpenEvaluationEvaluationInfoPage extends StatefulWidget {
  final Evaluation evaluation;
  final List<Goaltender> goaltenders;
  const OpenEvaluationEvaluationInfoPage(
      {super.key, required this.evaluation, required this.goaltenders});

  @override
  State<StatefulWidget> createState() {
    return OpenEvaluationEvaluationInfoPageState();
  }
}

class OpenEvaluationEvaluationInfoPageState
    extends State<OpenEvaluationEvaluationInfoPage> {
  List<DropdownMenuItem<String>> get gameTypeItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Game"), value: "Game"),
      DropdownMenuItem(child: Text("Practice"), value: "Practice"),
      DropdownMenuItem(child: Text("Scrimmage"), value: "Scrimmage"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }

  late Goaltender? selectedGoaltender;
  String selectedvalue = "";
  DateTime selectedDate =
      DateTime.now(); //temporarily like this until initState is called

  @override
  void initState() {
    super.initState();
    selectedvalue = widget.evaluation.evaluationType;
    selectedDate = widget.evaluation.evaluationDate;
    selectedGoaltender = widget.evaluation.goaltender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Paragraph("Goaltender"),
        const SizedBox(
          height: 5,
        ),
        // DropdownMenu<Goaltender>(
        //     width:
        //         500, // TODO: Make this the screen size-ish. idk how to do that
        //     enableSearch: true,
        //     initialSelection: widget.evaluation.goaltender,
        //     enableFilter: false,
        //     requestFocusOnTap: true,
        //     onSelected: (Goaltender? goaltender) {
        //       setState(() {
        //         selectedGoaltender = goaltender;
        //       });
        //     },
        // dropdownMenuEntries:
        //     widget.goaltenders.map((Goaltender goaltender) {
        //   return DropdownMenuEntry(
        //       value: goaltender, label: goaltender.name);
        // }).toList()),
        Container(
          margin: EdgeInsets.all(1),
          height: 40.0,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          child: Text(
            widget.evaluation.goaltender.name,
            //TODO: correct this color, idk how
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        ),
        Paragraph("Reassign evaluator"),
        const SizedBox(
          height: 5,
        ),
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
                print("pretend this did something");
              },
              child: Text(widget.evaluation.evaluator,
                  style: TextStyle(fontSize: 15)),
            )),
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
                  selectedDate = date;
                  // DateTime.parse('${date.month}/${date.day}/${date.year}');
                });
              }
            },
            child: Text(DateFormat('MM-dd-yyy').format(selectedDate)),
          ),
        ),
      ],
    );
  }
}

class OpenEvaluationCommentsPage extends StatelessWidget {
  Evaluation evaluation;

  OpenEvaluationCommentsPage({super.key, required this.evaluation});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = evaluation.comments; // initialize the text
    return Column(
      children: [
        TextField(
          controller: _controller,
          minLines: 10,
          maxLines: 10,
        ),
        ElevatedButton(
            onPressed: () {
              evaluation.comments = _controller.text;
              print(evaluation.comments);
            },
            child: const Text("Save comment")),
      ],
    );
  }
}

class OpenEvaluationSubmitPage extends StatefulWidget {
  final Evaluation evaluation;
  const OpenEvaluationSubmitPage({super.key, required this.evaluation});

  @override
  State<StatefulWidget> createState() {
    return OpenEvaluationSubmitPageState();
  }
}

class OpenEvaluationSubmitPageState extends State<OpenEvaluationSubmitPage> {
  void dataSaveScoring() {
    var db = FirebaseFirestore.instance;
    for (var catagory in widget.evaluation.fullScore.categoryScoreList) {
      db
          .collection("Goaltenders")
          .doc(widget.evaluation.goaltender.name)
          .collection("Evaluations")
          .doc(widget.evaluation.evaluationDate.toString().substring(0, 19))
          .collection("Scoring")
          .doc(catagory.name)
          .set({
        "Catagory": catagory.name,
        catagory.name: catagory.getAverage()
      });
      db
          .collection("Goaltenders")
          .doc(widget.evaluation.goaltender.name)
          .collection("Evaluations")
          .doc(widget.evaluation.evaluationDate.toString().substring(0, 19))
          .update({"Completed": true});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Goaltender: ${widget.evaluation.goaltender.name}");
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataTable(
                  border: TableBorder(
                      verticalInside: BorderSide(width: 1),
                      left: BorderSide(width: 1),
                      bottom: BorderSide(width: 1),
                      right: BorderSide(width: 1)),
                  columns: const [
                    DataColumn(label: Paragraph("Skill")),
                    DataColumn(label: Paragraph("Value")),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Paragraph("See")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("See")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Understand")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Understand")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Drive")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Drive")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Adapt")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Adapt")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Move")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Move")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Save")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Save")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Learn")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Learn")
                          .getAverage()
                          .toString())),
                    ]),
                    DataRow(cells: [
                      DataCell(Paragraph("Grow")),
                      DataCell(Paragraph(widget.evaluation.fullScore
                          .getCategoryScore("Grow")
                          .getAverage()
                          .toString())),
                    ]),
                  ]),
              // ElevatedButton(
              //     onPressed: () {
              //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //           content: Text("This button will update firebase")));
              //     },
              //     child: Text("Submit")),
              Header("Comments: "),
              Paragraph(widget.evaluation.comments)
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 50,
          width: 100,
          child: FloatingActionButton(
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(
              // SnackBar(content: Text("This button will update firebase")));
              dataSaveScoring();
              widget.evaluation.set_completed();
              Navigator.pop(context);
            },
            child: Text("Submit"),
            shape: RoundedRectangleBorder(),
          ),
        ),
        resizeToAvoidBottomInset: false);
  }
}
