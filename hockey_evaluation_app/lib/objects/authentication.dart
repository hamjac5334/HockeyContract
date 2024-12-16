import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/FAQ.dart';
import 'package:hockey_evaluation_app/pages/authentication_page.dart';
import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';
import 'package:hockey_evaluation_app/pages/evaluation_list_view.dart' as eval_list;
import 'package:hockey_evaluation_app/pages/new_organization.dart';
import 'package:hockey_evaluation_app/pages/organization_view.dart';
import 'package:hockey_evaluation_app/pages/settings.dart';
import 'package:hockey_evaluation_app/widgets/app_state.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';
import 'package:provider/provider.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/pages/join_organization_page.dart';
import 'package:hockey_evaluation_app/pages/organization_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthFunc extends StatefulWidget {
  const AuthFunc({
    Key? key,
    required this.loggedIn,
    required this.signOut,
    required this.goaltenders,
    required this.evaluations,
    required this.onGoaltenderListChanged,
    required this.onEvaluationListChanged,
  }) : super(key: key);

  final bool loggedIn;
  final void Function() signOut;
  final List<Goaltender> goaltenders;
  final List<Evaluation> evaluations;
  final Function(Goaltender) onGoaltenderListChanged;
  final Function(Evaluation) onEvaluationListChanged;

  @override
  _AuthFuncState createState() => _AuthFuncState();
}

class _AuthFuncState extends State<AuthFunc> {
  int current_screen_index = 0;
  String organization = "No Organization";
  String code = "No Code";


    void _cloudOrgPull() async{
      var db = FirebaseFirestore.instance;
      final FirebaseAuth auth = FirebaseAuth.instance;
      await db.collection("Users").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            ('${docSnapshot.id} => ${docSnapshot.data()}');
            if (auth.currentUser?.email == docSnapshot.id){
              organization = docSnapshot.data()["Organization"];
            }
          
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    await db.collection("Organization").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ('${docSnapshot.id} => ${docSnapshot.data()}');
          if (organization == docSnapshot.id){
            code = docSnapshot.data()["Code"];
          }
          
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  


//https://www.geeksforgeeks.org/switch-case-in-dart/
  Widget returnScreen() {
    _cloudOrgPull();
    switch (current_screen_index) {
      case 0:
        return _buildAuthButtons();
      case 1:
      return GoaltenderListView(
        items: widget.goaltenders,
        onGoaltenderListChanged: widget.onGoaltenderListChanged,
      );
    case 2:
      return eval_list.EvaluationListView(
      goaltenders: widget.goaltenders,
      items: widget.evaluations,
      onEvaluationListChanged: widget.onEvaluationListChanged,
      );
      //return TheseSettings();
      case 3:
      //once we have organizations, put here
      return TheseFAQ(); 
      case 4:
      //once we have notifications, put here
      if (organization == "No Organization"){
          return JoinOrganizationPage();
      }
      else{
        return OrganizationPage(organization: organization, code: code);
      }
      case 5:
        return TheseSettings();
      default:
        return _buildAuthButtons();
    }
  }

  void _navigateTo(int index) {
    setState(() {
      current_screen_index = index;
    });
  }

  Widget _buildAuthButtons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(
              'lib/image/logo.png',
              height: 175,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  if (widget.loggedIn) ...[
                    StyledButton(
                      onPressed: () => _navigateTo(2),
                      child: const Text('Evaluations'),
                    ),
                    StyledButton(
                      onPressed: () => _navigateTo(1),
                      child: const Text('Goaltenders'),
                    ),
                    StyledButton(
                      onPressed: () => _navigateTo(3),
                      child: const Text('Notifications'),
                    ),
                  ],
                ],
              ),
              Column(
                children: [
                  if (widget.loggedIn) ...[
                    StyledButton(
                      onPressed: () => _navigateTo(4),
                      child: const Text('Organization'),
                    ),
                    StyledButton(
                      onPressed: () => _navigateTo(5),
                      child: const Text('Settings'),
                    ),
                  ],
                  StyledButton(
                    onPressed: () {
                      if (!widget.loggedIn) {
                        context.go('/sign-in');
                      } else {
                        widget.signOut();
                      }
                    },
                    child: !widget.loggedIn
                    ? const Text('Sign In')
                    : const Text('Logout'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return returnScreen();
  }
}