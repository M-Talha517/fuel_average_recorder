import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuel_average_recorder/screens/authentication/signup.dart';
import 'package:fuel_average_recorder/services/authentication.dart';


class LoadingRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey[200],
        child: SpinKitRing(
          size: 100,
          color: Colors.white,
        ),
    );
  }
}


class SignInScreen extends StatefulWidget {
  final Function SwitchToSignUp;

  SignInScreen({this.SwitchToSignUp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';

  String error ='';
  final _formkey = GlobalKey<FormState>();
  final Authentication _auth = new Authentication();
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading? LoadingRing() :  Scaffold(
        appBar: AppBar(
          title: Text('Sign In Screen'),
          backgroundColor: Colors.blueGrey[700],
          actions: [
            FlatButton.icon(onPressed: () => widget.SwitchToSignUp(), icon: Icon(Icons.person), label: Text('SignUp'))
          ],

        ),
        backgroundColor: Colors.blueGrey[200],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [

                SizedBox(height: 10,),
                //TextForm For Email Address
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white.withOpacity(.5),
                    filled: true,
                  ),
                  validator: (val) => val.isEmpty? 'Enter An Email': null ,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 15,),
                //TextForm For Password
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white.withOpacity(.5),
                    filled: true,
                  ),
                  validator: (val) => val.length < 6? 'Enter A Password 6+ Character Long': null ,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 12,),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child:  Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    color: Colors.blueGrey[700],
                    onPressed: ()async{
                      if(_formkey.currentState.validate()) {
                        setState(() => loading=true);
                        dynamic result = await _auth.signInwithEmailAndPassword(email, password);
                        if(result == null){
                           setState(() {
                              loading = false;
                              error = 'Invalid email or password';
                            });
                        }
                      }
                    }
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  error,
                  style:TextStyle(
                    color: Colors.red,
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
