import 'package:flutter/material.dart';
import 'package:hockey_evaluation_app/widgets/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
        title: Text('Sign in to Goaltender Evaluations')
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.red), foregroundColor:WidgetStateProperty.all<Color>(Colors.black)),
          child: Text('Sign In'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null){
              print("error signing in");
            }
            else{
              print('signed in'); 
              print(result.uid);
            }
            }
        ),
      ),
    );
  }
}