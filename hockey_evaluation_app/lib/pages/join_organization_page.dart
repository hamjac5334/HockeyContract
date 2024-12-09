import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/pages/new_organization.dart';
import 'package:hockey_evaluation_app/pages/settings.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';
import 'package:restart_app/restart_app.dart';


class JoinOrganizationPage extends StatefulWidget {
   

  @override
  State<StatefulWidget> createState() {
    return JoinOrganizationPageState();
  }
}

class JoinOrganizationPageState extends State<JoinOrganizationPage> {
  String organizationCode = "No code entered";
  String organization = "No Organization";

  void organizationAccess()async {
     var db = FirebaseFirestore.instance;
     await db.collection("Codes").get().then(
      (querySnapshot) {
        print("codes completed");
        for (var docSnapshot in querySnapshot.docs) {
          print(docSnapshot.id);
          if(docSnapshot.id == organizationCode){
            print("Updating Org");
            organization = docSnapshot.data()["Organization"];
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    dataSave();
    Restart.restartApp(notificationTitle: 'Restarting App',
		notificationBody: 'Please tap here to open the app again.',);
  }
  

  void dataSave() {
    var db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
        db.collection("Users").doc(auth.currentUser?.email).set({
      "Organization": organization,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        title: const Text("No Organization"),
        titleTextStyle: TextStyle(
          fontSize: 44,
          color: Color.fromARGB(255, 80, 78, 78),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    organizationCode = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(labelText: "Organization Code", floatingLabelAlignment: FloatingLabelAlignment.center, border: OutlineInputBorder()),
              ),
              StyledButton(child: Text("Join"), 
                onPressed: () {
                  organizationAccess();
                  setState(() {
                    
                  });

                } ),
              StyledButton
              (onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewOrganizationPage()));
              }, 
              child: Text("Register New Organization"))
            ],
          ),
        ),
      ),
      );
  }
}