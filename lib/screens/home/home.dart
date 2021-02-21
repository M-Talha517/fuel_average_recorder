import 'package:flutter/material.dart';
import 'package:fuel_average_recorder/services/authentication.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Average Recorder'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(

              onPressed: (){
                  _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
