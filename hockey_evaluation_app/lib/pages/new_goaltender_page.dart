import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';

typedef GoaltenderListChangedCallback = Function(Goaltender goaltender);

class NewGoaltenderPage extends StatefulWidget {
  final GoaltenderListChangedCallback onGoaltenderListChanged;

  const NewGoaltenderPage({super.key, required this.onGoaltenderListChanged});

  @override
  State<StatefulWidget> createState() {
    return NewGoaltenderPageState();
  }
}

class NewGoaltenderPageState extends State<NewGoaltenderPage> {
  String goaltenderName = "";
  String levelAge = "";
  String organization = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Goaltender"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                goaltenderName = value;
              });
            },
            decoration: const InputDecoration(labelText: "Goaltender Name"),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                levelAge = value;
              });
            },
            decoration: const InputDecoration(labelText: "Level/Age"),
          ),
          TextField(
            onChanged: (value) {
              organization = value;
            },
            decoration: const InputDecoration(labelText: "Organization"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        widget.onGoaltenderListChanged(Goaltender(
            name: goaltenderName,
            levelAge: levelAge,
            organization: organization));
        Navigator.pop(context);
      }),
    );
  }
}
