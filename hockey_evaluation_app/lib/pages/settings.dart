import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/objects/score_list.dart';
import 'package:hockey_evaluation_app/objects/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:go_router/go_router.dart';


//put in a main function to run page individually
void main() {
  runApp(MaterialApp(
    theme: appTheme,
    home: DrawerScreen(),
  ));
}




class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});
  

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  
  final _auth = Auth(); 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            // Add spacing between image and title
            Flexible(
              // This prevents the overflow
              child: Text(
                "Hockey Evaluation App",
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
              "Hockey Evaluation App",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Home",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                print("tapped");
                setState(() {

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
                context.go('/goalies');
                setState(() {
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
                context.go('/evaluations');
                setState(() {

                });
                Navigator.pop(context); 
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
                print("Pretend this opened an organization page");
                Navigator.pop(context); 
              },
              leading: const Icon(Icons.roofing),
            ),
            ListTile(
              title: Text(
                "Settings",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                print("Pretend this opened a settings page");
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
                print("This should log out");
                Navigator.pop(context); 
              },
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
         "This is just a placeholder until I know what goes on this screen"
        ),
      ),
    );
  }
}

// Assuming a mock Auth class for signOut functionality
class Auth {
  Future<void> signOut() async {
    // Mock sign-out action
    print('Signed out');
  }
}