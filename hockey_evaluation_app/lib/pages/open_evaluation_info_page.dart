import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/scoring_page.dart';
import 'package:hockey_evaluation_app/widgets/goaltender_item.dart';
import 'package:hockey_evaluation_app/widgets/widgets.dart';

class OpenEvaluationInfoPage extends StatelessWidget {
  Evaluation evaluation;
  final List<Goaltender> goaltenders;
  OpenEvaluationInfoPage(
      {super.key, required this.evaluation, required this.goaltenders});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(evaluation.goaltender.name),
          bottom: const TabBar(tabs: [
            Text("Evaluation Info"),
            Text("Scoring"),
            Text("Comments"),
            Text("Submit")
          ]),
        ),
        body: TabBarView(children: [
          OpenEvaluationEvaluationInfoPage(
            evaluation: evaluation,
            goaltenders: goaltenders,
          ),
          //change this to be a actual widget
          EvaluationUI(),
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
        DropdownMenu<Goaltender>(
            width:
                500, // TODO: Make this the screen size-ish. idk how to do that
            enableSearch: true,
            initialSelection: widget.evaluation.goaltender,
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
        // Container(
        //   margin: EdgeInsets.all(1),
        //   height: 40.0,
        //   width: double.infinity,
        //   child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         // text color
        //         padding: EdgeInsets.all(5),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(0.0),
        //         ),
        //       ),
        //       onPressed: () {
        //         print("Pretend this did something");
        //       },
        //       child: Text(
        //         widget.evaluation.name,
        //         style: TextStyle(fontSize: 15),
        //       )),
        // ),
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
                  selectedDate =
                      DateTime.parse('${date.month}/${date.day}/${date.year}');
                });
              }
            },
            child: Text(selectedDate.toString()),
          ),
        ),
        Paragraph("Additional Notes"),
        OpenEvaluationCommentsPage(evaluation: widget.evaluation)
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataTable(
            border: TableBorder(verticalInside: BorderSide(width: 1)),
            columns: const [
              DataColumn(label: Text("Skill")),
              DataColumn(label: Text("Average")),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("See")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Understand")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Drive")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Adapt")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Move")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Save")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Learn")),
                DataCell(Text("Value")),
              ]),
              DataRow(cells: [
                DataCell(Text("Grow")),
                DataCell(Text("Value")),
              ]),
            ]),
        Text("Comments: "),
        Paragraph(widget.evaluation.comments)
      ],
    );
  }
}
