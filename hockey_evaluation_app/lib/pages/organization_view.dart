import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';
import 'package:hockey_evaluation_app/pages/new_organization.dart';
import 'package:hockey_evaluation_app/pages/settings.dart';


class OrganizationPage extends StatefulWidget {
  final String organization;
  final String code;
  OrganizationPage({super.key, required this.organization,  required this.code});
   

  @override
  State<StatefulWidget> createState() {
    return OrganizationPageState(organization: organization, code: code);
  }
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}