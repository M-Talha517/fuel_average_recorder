import 'package:flutter/material.dart';
import 'package:fuel_average_recorder/screens/authentication/signin.dart';
import 'package:fuel_average_recorder/screens/authentication/signup.dart';

import 'package:fuel_average_recorder/services/authentication.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool signInScreen = true;

  void switchScreen(){
    setState(() {
      signInScreen = !signInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (signInScreen) {
      return SignInScreen(SwitchToSignUp: switchScreen);
    } else {
      return SignUpScreen(SwitchToSignIn: switchScreen,);
    }
  }
}
