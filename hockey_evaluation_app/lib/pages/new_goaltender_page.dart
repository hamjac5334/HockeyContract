import 'package:firebase_auth/firebase_auth.dart';
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

    //db.collection("Goaltenders").doc(goaltenderName).collection("Evaluations").doc("Evaluation").set({"Name": goaltenderName, "Level/Age": levelAge, "Organization" : organization});
    db.collection("Goaltenders").doc(goaltenderName + organization).set({
      "Name": goaltenderName,
      "Level/Age": levelAge,
      "Organization": organization
    });
  }

  @override
  Widget build(BuildContext context) {
    _cloudOrgPull();
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
                key: const Key("GoaltenderNameTextField"),
                onChanged: (value) {
                  setState(() {
                    goaltenderName = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Goaltender Name"),
              ),
              TextField(
                key: const Key("GoaltenderAgeTextField"),
                onChanged: (value) {
                  setState(() {
                    levelAge = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Level/Age"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var b;
          b = widget.onGoaltenderListChanged(Goaltender(
              name: goaltenderName,
              levelAge: levelAge,
              organization: organization));
          if (b) {
            dataSave();
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.add),
        hoverColor: Color.fromARGB(255, 122, 10, 10),
        backgroundColor: Color.fromARGB(255, 122, 10, 10),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}
