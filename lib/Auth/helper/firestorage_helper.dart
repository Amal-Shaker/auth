import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestorgeHelper {
  FirestorgeHelper._();
  static FirestorgeHelper firestorgeHelper = FirestorgeHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  uploadImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = "images/profiles/$fileName";
    Reference reference = firebaseStorage.ref(path);
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
