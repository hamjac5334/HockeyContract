import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/evaluation_list_view.dart';
import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:hockey_evaluation_app/widgets/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:hockey_evaluation_app/objects/authentication.dart';
import 'package:hockey_evaluation_app/widgets/app_state.dart';

import 'package:hockey_evaluation_app/widgets/app_drawer.dart';
import 'package:hockey_evaluation_app/objects/authentication.dart';

//transparent image in the background of homepage
//source of image: hockey_evaluation_app/lib/image/logo.png



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hockey Evaluation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int current_screen_index = 0;

  /*final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => MyHomePage()),
    GoRoute(path: '/goalies', builder: (context, state) => GoaliesPage()),
    GoRoute(
          path: '/evaluations',
          builder: (context, state) {
            return EvaluationListView(
                goaltenders: _MyHomePageState().goaltenders,
                items: _MyHomePageState().evaluations,
                onEvaluationListChanged:
                    _MyHomePageState()._handleNewEvaluation);
          },
        ),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    // Add other routes as needed
  ],
);*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Flexible(
              child: Text(
                "Hockey Evaluation App",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(width: 14),
            Image.asset(
              'lib/image/logo.png', 
              height: 40,
            ),
          ],
        ),
      ),
      drawer: AppDrawer(authService: AuthService()),
        /*child: ListView(
          children: [
            ListTile(
              title: Text("Home", style: Theme.of(context).textTheme.bodySmall),
              onTap: () {
                //current_screen_index = 0;
                //Navigator.of(context).pushReplacement(
                  //MaterialPageRoute(builder: (context) => MyApp()),
                //);
                context.go('/goalies');
                setState(() {
                  current_screen_index = 1;
                });
              },
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text("Goaltenders",style: Theme.of(context).textTheme.bodySmall,),
              onTap: () {
                print("Goaltenders page opened");
                
                //navigate to import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';
                
              },
              leading: Icon(Icons.people),
            ),
            ListTile(
              title: Text(
                "Evaluations",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                current_screen_index = 0;
              },
              leading: const Icon(Icons.note),
            ),
            ListTile(
              title: Text(
                "Notifications",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                print("Pretend this opened a notifications page");
              },
              leading: const Icon(Icons.notifications),
            ),
            ListTile(
              title: Text(
                "Organization",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                print("Pretend this opened an organization page");
              },
              leading: const Icon(Icons.roofing),
            ),
            ListTile(
              title: Text("Settings",style: Theme.of(context).textTheme.bodySmall),
              onTap: () {
                print("Settings page opened");
              },
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("Logout",style: Theme.of(context).textTheme.bodySmall),
              onTap: () async {
                await _auth.signOut();
                print("Logged out");
              },
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //mock this for rn and then try to get gorouter working
                //CHANGE THIS 
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GoaltenderListView(
                      items: [], 
                        onGoaltenderListChanged: (goaltender) {}, 
                    ),
                  ),
                );
                //context.go('/goalies');
                setState(() {
                  current_screen_index = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                overlayColor: Colors.black,
              ),
              child: Text('Goaltenders'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EvaluationListView(
                      items: <Evaluation>[], 
                      goaltenders: <Goaltender>[], 
                      onEvaluationListChanged: (evaluation) {
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                overlayColor: Colors.black,
              ),
              child: Text('Evaluations'),
            ),
            ElevatedButton(
              onPressed: () {
                // route her
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                overlayColor: Colors.black,
              ),
              child: Text('Notifications'),
            ),
            ElevatedButton(
              onPressed: () {
                // route here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                overlayColor: Colors.black,
              ),
              child: Text('Organization'),
            ),
            ElevatedButton(
              onPressed: () {
                // route here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                overlayColor: Colors.black,
              ),
              child: Text('Settings'),
            ),
        ],
      ),
      ),
    );
  }
}