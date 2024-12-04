import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
                // This prevents the overflow
                child: Image.asset(
                'lib/image/logo.png', // Path to image file
                height: 40,
                width: double.infinity,
                fit: BoxFit.cover, // Adjust height as needed
              ),),
              SizedBox(height: 20),
          if (loggedIn) ...[
            StyledButton(
              onPressed: () {
                context.go('/evaluations');
              },
              child: const Text('Evaluations'),
            ),
            StyledButton(
              onPressed: () {
                context.go('/goalies');
              },
              child: const Text('Goaltenders'),
            ),
            StyledButton(
              onPressed: () {
                //context.go('');
                print("Pretend this opened a notifications page");
              },
              child: const Text('Notifications'),
            ),
            StyledButton(
              onPressed: () {
                //context.go('');
                print("Pretend this opened an Organization page");
              },
              child: const Text('Organization'),
            ),
            StyledButton(
              onPressed: () {
                context.go('/settings');
              },
              child: const Text('Settings'),
            ),
          ],
          StyledButton(
            onPressed: () {
              if (!loggedIn) {
                context.go('/sign-in');
              } else {
                signOut();
              }
            },
            child: !loggedIn ? const Text('Sign In') : const Text('Logout'),
          ),
        ],
      ),
    );
  }
}