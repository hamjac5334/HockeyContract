import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  void dataSave() {
    var db = FirebaseFirestore.instance;

    //db.collection("Goaltenders").doc(goaltenderName).collection("Evaluations").doc("Evaluation").set({"Name": goaltenderName, "Level/Age": levelAge, "Organization" : organization});
    db.collection("Goaltenders").doc(goaltenderName).set({
      "Name": goaltenderName,
      "Level/Age": levelAge,
      "Organization": organization
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Goaltender"),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 80, 78, 78),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataSave();
          widget.onGoaltenderListChanged(Goaltender(
              name: goaltenderName,
              levelAge: levelAge,
              organization: organization));
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
