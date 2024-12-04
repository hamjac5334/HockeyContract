import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/pages/new_organization.dart';
import 'package:hockey_evaluation_app/pages/settings.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';


class OrganizationPage extends StatefulWidget {
  final String organization;
  final String code;
  OrganizationPage({super.key, required this.organization,  required this.code});
   

  @override
  State<StatefulWidget> createState() {
    return OrganizationPageState(organization: organization, code: code);
  }
}

void leave(){
    var db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    db.collection("Users").doc(auth.currentUser?.email).set({
      "Organization": "No Organization",
    });
  }

class OrganizationPageState extends State<OrganizationPage> {
  final String organization;
  final String code;
  OrganizationPageState({required this.organization,  required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization: " + organization),
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
            children:[
              Text("Code: " + code),
              StyledButton
              (onPressed: (){
                leave();
              }, 
              child: Text("Leave Organization"))
            ],
          ),
        ),
      ),
    );
  }
}