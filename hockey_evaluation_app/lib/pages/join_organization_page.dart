import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/pages/new_organization.dart';
import 'package:hockey_evaluation_app/pages/settings.dart';


class JoinOrganizationPage extends StatefulWidget {
   

  @override
  State<StatefulWidget> createState() {
    return JoinOrganizationPageState();
  }
}

class JoinOrganizationPageState extends State<JoinOrganizationPage> {
  String organizationCode = "No code entered";
  String organization = "No Organization";

  void organizationAccess(){
    var db = FirebaseFirestore.instance;
      db.collection("Codes").get().then(
      (querySnapshot) {
        print("codes completed");
        for (var docSnapshot in querySnapshot.docs) {
          if(docSnapshot == organizationCode){
            organization = docSnapshot.data()["organization"];
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

  }

  

  void dataSave() {
    var db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    //db.collection("Goaltenders").doc(goaltenderName).collection("Evaluations").doc("Evaluation").set({"Name": goaltenderName, "Level/Age": levelAge, "Organization" : organization});
    db.collection("Users").doc(auth.currentUser?.email).set({
      "Organization": organization,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("No Organization"),
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
                    organizationCode = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Organization Code"),
              ),
              IconButton
              (onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewOrganizationPage()));
              }, 
              icon: Text("Register New Organization"))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            
          });
          dataSave();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}