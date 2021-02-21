import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuel_average_recorder/services/authentication.dart';


class LoadingRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[200],
      child: SpinKitRing(
        size: 100,
        color: Colors.white,
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final Function SwitchToSignIn;


  // ignore: non_constant_identifier_names
  SignUpScreen({this.SwitchToSignIn});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String error ='';
  final _formkey = GlobalKey<FormState>();
  final Authentication _auth = new Authentication();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? LoadingRing() : Scaffold(
        appBar: AppBar(
          title: Text('Signing Up Screen'),
          backgroundColor: Colors.blueGrey[700],
          actions: [
            FlatButton.icon(onPressed: () => widget.SwitchToSignIn(), icon: Icon(Icons.person), label: Text('SignIn'))
          ],
        ),
        backgroundColor: Colors.lightGreen[200],
        body: Padding(

          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    //TextForm For Email Address
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          fillColor: Colors.white.withOpacity(.5),
                          filled: true,
                        ),
                        validator: (val) => val.isEmpty? 'Enter First Name': null ,
                        onChanged: (val){
                          setState(() => firstName = val);
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          fillColor: Colors.white.withOpacity(.5),
                          filled: true,
                        ),
                        validator: (val) => val.isEmpty? 'Enter Last Name': null ,
                        onChanged: (val){
                          setState(() => lastName = val);
                        },
                      ),
                    ),
                  ],
                ),
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
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    color: Colors.blueGrey[700],
                    onPressed: ()async{
                      if(_formkey.currentState.validate()) {
                        setState(() => loading=true);
                        if(await _auth.signUpwithEmailAndPassword(email, password,firstName,lastName) == null){
                          setState(() {
                            loading = false;
                            error = 'please provide a valid email';
                          });
                        }
                      }
                    },

                  ),
                ),
                SizedBox(height: 12,),
                Text(
                    error,
                    style:TextStyle(
                      color: Colors.red,
                    ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
