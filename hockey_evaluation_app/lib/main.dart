import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/category_score.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/full_score.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/evaluation_list_view.dart';
import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:hockey_evaluation_app/pages/join_organization_page.dart';
import 'package:hockey_evaluation_app/pages/organization_view.dart';
import 'package:hockey_evaluation_app/pages/settings.dart';
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
import 'package:restart_app/restart_app.dart';

Color redtheme = const Color.fromRGBO(254, 48, 60, 1);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _MyHomePageState()._cloudGoaltenderPull();
    return MaterialApp.router(
        title: 'Hockey Evaluation App',
        //theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
        // ),
        theme: appTheme,
        routerConfig: _router);
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: 'Hockey Evaluation App'),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null
                  };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            return const TheseSettings();
          },
        ),
      ],
    ),
  ],
);

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  int current_screen_index = 0;

  var db = FirebaseFirestore.instance;

  List<Goaltender> goaltenders = [];
  List<Evaluation> evaluations = [];

  String organization = "No Organization";
  String code = "No Code Generated";

  void _cloudGoaltenderPull() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await db.collection("Goaltenders").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs){
          if (auth.currentUser?.email == "goaltenderevaluation@gmail.com"){
            goaltenders.add(Goaltender(
              name: docSnapshot.data()['Name'],
              levelAge: docSnapshot.data()['Level/Age'],
              organization: docSnapshot.data()['Organization']));
              db.collection("Goaltenders").doc(docSnapshot.data()['Name']).collection("Evaluations").get().then(
                (querySnapshotEvals)  {
                    for (var eval in querySnapshotEvals.docs){
                      print("Adding Eval");
                      Evaluation temp_evaluation = Evaluation(
                        goaltender: Goaltender(name: docSnapshot.data()['Name'], levelAge: docSnapshot.data()['Level/Age'], organization: docSnapshot.data()['Organization']),
                        evaluationDate: (eval.data()["Evaluation Date"] as Timestamp).toDate(),
                        evaluationType: eval.data()['Evaluation Type'],
                        //TODO: Change this to be the scores stored on firebase
                        fullScore: FullScore());
                        evaluations.add(temp_evaluation);
                        db.collection("Goaltenders").doc(docSnapshot.data()["Name"]).collection("Evaluations").doc(eval.id).collection("Scoring").get().then(
                          (querySnapshotscore){
                            for (var score in querySnapshotscore.docs){
                              score.data()["score"].toString();
                            }
                          }
                        );   
                  }
                }
              );
            } 
          else {
            if (docSnapshot.data()['Organization'] == organization)  {
            goaltenders.add(Goaltender(
              name: docSnapshot.data()['Name'],
              levelAge: docSnapshot.data()['Level/Age'],
              organization: docSnapshot.data()['Organization']));
               db.collection("Goaltenders").doc(docSnapshot.data()['Name']).collection("Evaluations").get().then(
                (querySnapshotEvals)  {
                    for (var eval in querySnapshotEvals.docs){
                      print("Adding Eval");
                      print(docSnapshot.data()['Name'] + ' ' + docSnapshot.data()['Level/Age']+ ' '  + docSnapshot.data()['Organization']+ ' '  + eval.data()['Evaluation Type']);
                      Evaluation temp_evaluation = Evaluation(
                        goaltender: Goaltender(name: docSnapshot.data()['Name'], levelAge: docSnapshot.data()['Level/Age'], organization: docSnapshot.data()['Organization']),
                        evaluationDate: (eval.data()["Evaluation Date"] as Timestamp).toDate(),
                        evaluationType: eval.data()['Evaluation Type'],
                        //TODO: Change this to be the scores stored on firebase
                        fullScore: FullScore());
                        evaluations.add(temp_evaluation);
                  }
                }
              );
          }
          
        }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    for (Goaltender goaltender in goaltenders) {
      print("Goaltender: ${goaltender.name}");
    }
  }


  //TODO: the way the data is stored in firebase is based on the evaluation having a name, instead of it having a goaltender


  void _cloudOrgPull() async{
    goaltenders.clear(); 
    evaluations.clear();
    //TODO: Find a solution that does not resort to this!
    final FirebaseAuth auth = FirebaseAuth.instance;
    await db.collection("Users").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ('${docSnapshot.id} => ${docSnapshot.data()}');
          if (auth.currentUser?.email == docSnapshot.id){
            organization = docSnapshot.data()["Organization"];
            print(organization);
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
            print(code);
          }
          
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    _cloudGoaltenderPull();
  }

  void _handleNewGoaltender(Goaltender goaltender) {
    setState(() {
      goaltenders.add(goaltender);
    });
  }

  void _handleNewEvaluation(Evaluation evaluation) {
    setState(() {
      evaluations.add(evaluation);
    });
  }

  @override
  void initState() {
    super.initState();
      _cloudOrgPull(); //this pulls both goaltender and eval
  }

  Widget returnScreen() {
    if (current_screen_index == 0) {
      //return the page.
      return Consumer<ApplicationState>(
        builder: (context, appState, _) {
          return AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
              goaltenders: goaltenders,
              evaluations: evaluations,
              onGoaltenderListChanged: _handleNewGoaltender,
              onEvaluationListChanged: _handleNewEvaluation,
              );
        },
      );
    } else if (current_screen_index == 1) {
      return GoaltenderListView(
        items: goaltenders,
        onGoaltenderListChanged: _handleNewGoaltender,
      );
    } else if (current_screen_index == 2) {
      return EvaluationListView(
        goaltenders: goaltenders,
        items: evaluations,
        onEvaluationListChanged: _handleNewEvaluation,
      );
    } else if (current_screen_index == 3) {
        //_cloudOrgPull();
        if (organization == "No Organization"){
          return JoinOrganizationPage();}
        else{
          return OrganizationPage(organization: organization, code: code);
        }
    
    } else if (current_screen_index == 4) {
        //_cloudOrgPull();
        return TheseSettings();
    
    } else if (current_screen_index == 5) {
        //_cloudOrgPull();
        return TheseSettings();
    
    } else {
      print("Something is wrong");
      return EvaluationListView(
          items: evaluations,
          onEvaluationListChanged: _handleNewEvaluation,
          goaltenders: goaltenders);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            children: [
              // Add spacing between image and title
              Flexible(
                // This prevents the overflow
                child: Image.asset(
                'lib/image/logo.png', // Path to image file
                height: 40,
                fit: BoxFit.cover, // Adjust height as needed
              ),
                
                /*Text(
                  widget.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  //overflow: TextOverflow
                  //   .ellipsis, // Adds ellipsis if text is too long
                ),*/
              ),
              /*SizedBox(width: 14),
              Image.asset(
                'lib/image/logo.png', // Path to image file
                height: 40,
                fit: BoxFit.cover, // Adjust height as needed
              ),
              SizedBox(width: 1), // Spacing between image and title
              Text(
                widget.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),*/
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Text(
                  "Home",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("tapped");
                  setState(() {
                    current_screen_index = 0;
                  });
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text(
                  "Goaltenders",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() {
                    current_screen_index = 1;
                  });
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.people),
              ),
              ListTile(
                title: Text(
                  "Evaluations",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("Evaluations: $evaluations");

                  setState(() {
                    current_screen_index = 2;
                  });
                  Navigator.pop(context);

                  //context.go('/evaluations');
                },
                leading: const Icon(Icons.note),
              ),
              ListTile(
                title: Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() {
                    current_screen_index = 4;
                  });
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.notifications),
              ),
              ListTile(
                title: Text(
                  "Organization",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() {
                    current_screen_index = 3;
                  });
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.roofing),
              ),
              //make sure to include account information Settings
              ListTile(
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  setState(() {
                    current_screen_index = 5;
                  });
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.settings),
              ),

              ListTile(
                title: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () async {
                  await _auth.signOut();
                  Restart.restartApp(notificationTitle: 'Restarting App',
		                notificationBody: 'Please tap here to open the app again.',);
                  print("This should log out");
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.logout),
              )
            ],
          ),
        ),
        body:
            //consumer leads to authentication, cannot figure out how to route to app when logged in, can route to pages through go route
            returnScreen()

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        );
  }
}
