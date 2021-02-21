import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final uid ;
  DatabaseService({this.uid});
  final CollectionReference users = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String firstName,String lastName,int noOfVehicles) async{
    return await users.doc(uid).set({
      'firstName' : firstName,
      'lastName' : lastName,
      '#vehicles' : noOfVehicles,
    });
  }

}