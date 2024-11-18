import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/evaluation.dart';
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/evaluation_list_view.dart';
import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:hockey_evaluation_app/widgets/auth.dart';
import 'package:hockey_evaluation_app/widgets/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; 
import 'package:go_router/go_router.dart';              
import 'package:provider/provider.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' 
    hide EmailAuthProvider, PhoneAuthProvider;    
import 'package:hockey_evaluation_app/objects/authentication.dart';
import 'package:hockey_evaluation_app/widgets/app_state.dart';   
                       // new


                                         


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
    return 
      MaterialApp.router(
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

      routerConfig: _router
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  MyHomePage( title: 'Hockey Evaluation App'),
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
          path: '/evaluations',
          builder: (context, state) {
            return EvaluationListView(items: _MyHomePageState().evaluations, onEvaluationListChanged: _MyHomePageState()._handleNewEvaluation);
          },
        ),
        GoRoute(
          path: '/goalies',
          builder: (context, state) {
            return GoaltenderListView(items: _MyHomePageState().goalies, onGoaltenderListChanged: _MyHomePageState()._handleNewGoaltender);
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
  List<Evaluation> evaluations = [
    Evaluation(
        name: "Colten Berry",
        evaluationDate: DateTime.now(),
        evaluationType: "Epic"),
    Evaluation(
        name: "Jack Hamilton",
        evaluationDate: DateTime.now(),
        evaluationType: "Pretty Cool"),
    Evaluation(
        name: "Sam LastName",
        evaluationDate: DateTime.now(),
        evaluationType: "I guess he's alright")
  ];

  List<Goaltender> goalies = [
    Goaltender(
        name: "Colten Berry", levelAge: "21", organization: "Hendrix College"),
    Goaltender(name: "Jack", levelAge: "21", organization: "Hendrix College"),
    Goaltender(name: "Sarah", levelAge: "21", organization: "Hendrix College")
  ];

  void _handleNewGoaltender(Goaltender goaltender) {
    setState(() {
      goalies.add(goaltender);
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
    Evaluation e = Evaluation(
        name: "Closed Evaluation 1",
        evaluationDate: DateTime.now(),
        evaluationType: "Howdy");

    e.set_completed();

    evaluations.add(e);

    e = Evaluation(
        name: "Closed Evaluation 2",
        evaluationDate: DateTime.now(),
        evaluationType: "evaluationType");
    e.set_completed();
    evaluations.add(e);
  }

  Widget returnScreen() {
    if (current_screen_index == 0) {
      //return the page.
      return EvaluationListView(
        items: evaluations,
        onEvaluationListChanged: _handleNewEvaluation,
      );
    } else if (current_screen_index == 1) {
      return GoaltenderListView(
        items: goalies,
        onGoaltenderListChanged: _handleNewGoaltender,
      );
    } else {
      print("Something is wrong. Main Line 126");
      return EvaluationListView(
        items: evaluations,
        onEvaluationListChanged: _handleNewEvaluation,
      );
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
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  //overflow: TextOverflow
                  //   .ellipsis, // Adds ellipsis if text is too long
                ),
              ),
              SizedBox(width: 14),
              Image.asset(
                'lib/image/logo.png', // Path to image file
                height: 40, // Adjust height as needed
              ),
              SizedBox(width: 1), // Spacing between image and title
              Text(
                widget.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
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
                  current_screen_index = 0;
                },
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text(
                  "Goaltenders",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  context.go('/goalies');
                  setState(() {
                    current_screen_index = 1;
                  });
                  //context.go('/goalies');
                },
                leading: const Icon(Icons.people),
              ),
              ListTile(
                title: Text(
                  "Evaluations",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  context.go('/evaluations');
                  setState(() {
                    current_screen_index = 0;
                  });
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
              //make sure to include account information Settings
              ListTile(
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  print("Pretend this opened a settings page");
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
                  print("This should log out");
                },
                leading: const Icon(Icons.logout),
              )
            ],
          ),
        ),
        body: 
        //consumer leads to authentication, cannot figure out how to route to app when logged in, can route to pages through go route
        Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
                
          ),
         //returnScreen()
        
        
        
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
