import 'package:chat_app_with_firebase/model/countrymodel.dart';
import 'package:chat_app_with_firebase/model/register_request.dart';
import 'package:chat_app_with_firebase/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addToFirestore(RegisterRequest registerRequest) async {
    //firebaseFirestore.collection('Users').add(registerRequest.toMap());
    await firebaseFirestore
        .collection('Users')
        .doc(registerRequest.id)
        .set(registerRequest.toMap());
  }

  getUserFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
    print(documentSnapshot.data());
  }

  // Future<List<UserModel>> getAllUsersFromFirestore() async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await firebaseFirestore.collection('Users').get();
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
  //   List<UserModel> users =
  //       docs.map((e) => UserModel.fromMap(e.data())).toList();
  //   print(users.length);
  //   // return users;
  // }
  Future<List<UserModel>> getAllUsersFromFirestore() async {
    // QuerySnapshot<Map<String, dynamic>> querySnapshot =
    //     await firebaseFirestore.collection('Users').get();
    // List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    // List<UserModel> users =
    //     docs.map((e) => UserModel.fromMap(e.data())).toList();
    // print(users.length);
    final listOfUser = await firebaseFirestore.collection('Users').get();
    final users =
        listOfUser.docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }

  getAllCountries() async {
    final listOfcountries =
        await firebaseFirestore.collection('countries').get();
    final countries = listOfcountries.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      CountryModel.fromJson(map);
    }).toList();
    print(countries.length);
    return countries;
  }
}
