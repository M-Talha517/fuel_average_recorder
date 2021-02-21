import 'package:fuel_average_recorder/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_average_recorder/services/database.dart';


class Authentication{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign-in via email
  Future signInwithEmailAndPassword(String email, String password) async{
    try{
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userToCurrUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //auth change user stream
  Stream<CurrUser> get currUser {
    return _auth.authStateChanges()
        .map(userToCurrUser);
  }

  //Convert Firebase user to CurrUser Object
  CurrUser userToCurrUser (User user){
    return user==null ? null : new CurrUser(uid: user.uid);
  }
  //sign-in anonymously
  Future signinAnon() async{
    try{
     UserCredential userCredential = await _auth.signInAnonymously();
     User user = userCredential.user;
     CurrUser currUser = userToCurrUser(user);
     return currUser;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign up
  Future signUpwithEmailAndPassword(String email, String password,String firstName , String lastName) async{
    try{
      dynamic result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid:user.uid).updateUserData(firstName, lastName, 0);
      return userToCurrUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign-out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}

}