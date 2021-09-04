import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestorgeHelper {
  FirestorgeHelper._();
  static FirestorgeHelper firestorgeHelper = FirestorgeHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File file, [String folderName = 'profile']) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = "images/$folderName/$fileName";
    Reference reference = firebaseStorage.ref(path);
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadAudio(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = "audio/$fileName.mp3";
    Reference reference = firebaseStorage.ref(path);
    await reference.putFile(file);

    String audioUrl = await reference.getDownloadURL();
    return audioUrl;
  }
}
