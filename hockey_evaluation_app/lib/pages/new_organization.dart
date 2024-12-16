import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:restart_app/restart_app.dart';

class NewOrganizationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return NewOrganizationPageState();
  }
}

class NewOrganizationPageState extends State<NewOrganizationPage> {
  String organization = "New Organization";
  String organizationManager = "New Manager";
  String code = "No code generated";

  void dataSave() {
    var db = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    //db.collection("Goaltenders").doc(goaltenderName).collection("Evaluations").doc("Evaluation").set({"Name": goaltenderName, "Level/Age": levelAge, "Organization" : organization});
    db.collection("Organization").doc(organization).set({
      "Organization": organization,
      "Manager": organizationManager,
      "Code": code
    });
    db.collection("Codes").doc(code).set({
      "Organization" : organization
    });
    db.collection("Users").doc(auth.currentUser?.email).update({
      "Organization" : organization
    });
    Restart.restartApp(notificationTitle: 'Restarting App',
		notificationBody: 'Please tap here to open the app again.',
    );
  }
  
  int randomCode(){
    return Random.secure().nextInt(999999) + 100000;
  }
  int codeGeneration(){
    int possibleCode = randomCode();
    var db = FirebaseFirestore.instance;
    db.collection("Codes").get().then(
      (querySnapshot) {
        print("Goaltenders completed");
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot == code){
            codeGeneration();
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return possibleCode;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Organization"),
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
              Padding(padding: EdgeInsets.all(15)),
              TextField(
                onChanged: (value) {
                  setState(() {
                    organization = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Organization Name"),
              ),
              Padding(padding: EdgeInsets.all(15)),
              TextField(
                onChanged: (value) {
                  setState(() {
                    organizationManager = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Manager Name"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          code = codeGeneration().toString();
          dataSave();
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
        hoverColor: Color.fromARGB(255, 122, 10, 10),
        backgroundColor: Color.fromARGB(255, 122, 10, 10),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
    );
  }
}