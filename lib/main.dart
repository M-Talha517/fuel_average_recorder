import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fuel_average_recorder/models/user.dart';
import 'package:fuel_average_recorder/screens/authentication/signup.dart';
import 'package:fuel_average_recorder/screens/wrapper.dart';
import 'package:fuel_average_recorder/services/authentication.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrUser>.value(
      value: Authentication().currUser,
      child: MaterialApp(
        title: 'Fuel Average Recorder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
