import 'package:chat_app_with_firebase/model/register_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addToFirestore(RegisterRequest registerRequest) {
    firebaseFirestore.collection('Users').add(registerRequest.toMap());
  }
}
