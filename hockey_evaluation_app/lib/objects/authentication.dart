import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hockey_evaluation_app/widgets/styledButton.dart';
import 'package:hockey_evaluation_app/main.dart';

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
          Visibility(
            visible: loggedIn,
            child: StyledButton(
              onPressed: () {
                context.go('/evaluations');
              },
              child: const Text('Evaluations'),
            ),
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
              print("Pretend this opened a Organization page");
            },
            child: const Text('Organization'),
          ),
          StyledButton(
            onPressed: () {
              //context.go('');
              print("Pretend this opened a settings page");
            },
            child: const Text('Settings'),
          ),
          StyledButton(
            onPressed: () {
              !loggedIn ? context.go('/sign-in') : signOut();
            },
            child: !loggedIn ? const Text('Sign In') : const Text('Logout'),
          ),
        ],
      ),
    );
  }
}