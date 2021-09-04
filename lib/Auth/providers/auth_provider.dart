import 'dart:io';

import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestorage_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/shared_helper.dart';
import 'package:chat_app_with_firebase/chat/alluser.dart';
import 'package:chat_app_with_firebase/chat/chat_page.dart';
import 'package:chat_app_with_firebase/chat/profile.dart';
import 'package:chat_app_with_firebase/model/countrymodel.dart';
import 'package:chat_app_with_firebase/model/register_request.dart';
import 'package:chat_app_with_firebase/model/usermodel.dart';
import 'package:chat_app_with_firebase/out_services/custom_dialog.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/HomePage.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountryFromFirestore();
  }
  String myId;
  checkLogin() {
    bool isLogining = AuthHelper.authHelper.checkLogin();
    getAllUsers();
    if (isLogining) {
      this.myId = AuthHelper.authHelper.getUserId();
      //RouteHelper.routeHelper.goToPageWithReplacement(ProfilePage.routeName);
      RouteHelper.routeHelper.goToPageWithReplacement(AllUser.routeName);
      // RouteHelper.routeHelper.goToPageWithReplacement(ChatPage.routeName);
    } else {
      RouteHelper.routeHelper.goToPageWithReplacement(Login.routeName);
    }
  }

  List<UserModel> users;
  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  dynamic selectCity;
  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectedCity(cities.first.toString());
    notifyListeners();
  }

/////////upload image
  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

  selectedCity(dynamic city) {
    this.selectCity = city;
    notifyListeners();
  }

  getCountryFromFirestore() async {
    List<CountryModel> countries =
        await FirestoreHelper.firestoreHelper.getAllCountries();
    this.countries = countries;
    notifyListeners();
  }

  UserModel user;
  getUserFromFirestore() async {
    var userId = await AuthHelper.authHelper.getUserId();
    print(userId);
    user =
        await FirestoreHelper.firestoreHelper.getAllUserFromFirestore(userId);
    notifyListeners();
  }

  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController fNmaeController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      var userCredential = await AuthHelper.authHelper
          .signup(emailController.text.trim(), passwordController.text.trim());

      print("frommmm auth provider${userCredential.user.uid}");

      String id = userCredential.user.uid;
      String imageUrl =
          await FirestorgeHelper.firestorgeHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
          imageUrl: imageUrl,
          id: id,
          email: emailController.text,
          password: passwordController.text,
          city: selectCity,
          country: selectedCountry.name,
          fName: fNmaeController.text,
          lName: lNameController.text);
      await FirestoreHelper.firestoreHelper.addToFirestore(registerRequest);
      resetControllers();

      // await AuthHelper.authHelper.verifyEmail();
      // await AuthHelper.authHelper.logout();
      //   tabController.animateTo(1);
    } on Exception catch (e) {
      // TODO
    }
// navigate to login
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text.trim(), passwordController.text.trim());
    RouteHelper.routeHelper.goToPage(AllUser.routeName);
    print("pppppppppppppppppppppp${userCredential.user.uid}");

    await FirestoreHelper.firestoreHelper
        .getAllUserFromFirestore(userCredential.user.uid);

    resetControllers();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text.trim());
    resetControllers();
  }

  getAllUsers() async {
    users = await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();

    notifyListeners();
  }

  File updatedFile;
  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    notifyListeners();
  }

  updateProfile() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl =
          await FirestorgeHelper.firestorgeHelper.uploadImage(updatedFile);
    }
    UserModel userModel = imageUrl == null
        ? UserModel(
            email: emailController.text.trim(),
            city: cityController.text,
            country: countryController.text,
            fName: fNmaeController.text,
            lName: lNameController.text,
            id: user.id)
        : UserModel(
            email: emailController.text.trim(),
            city: cityController.text,
            country: countryController.text,
            fName: fNmaeController.text,
            lName: lNameController.text,
            id: user.id,
            imageUrl: imageUrl);

    await FirestoreHelper.firestoreHelper.updateProfile(userModel);
    getUserFromFirestore();
    Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  }

  fillControllers() {
    emailController.text = user.email;
    fNmaeController.text = user.fName;
    lNameController.text = user.lName;
    countryController.text = user.country;
    cityController.text = user.city;
  }

  sendImageToChats([String message]) async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    String imageUrl = await FirestorgeHelper.firestorgeHelper
        .uploadImage(File(file.path), 'chats');
    FirestoreHelper.firestoreHelper.addMessageToFirestore({
      'userId': this.myId,
      'dateTime': DateTime.now(),
      //'message': message ?? '',
      'imageUrl': imageUrl
    });
  }

  sendImageToChatRoom(String twoId, [String message]) async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    String imageUrl = await FirestorgeHelper.firestorgeHelper
        .uploadImage(File(file.path), 'chats');
    FirestoreHelper.firestoreHelper.addMessageChatRoom({
      'userId': this.myId,
      'dateTime': DateTime.now(),
      //'message': message ?? '',
      'imageUrl': imageUrl
    }, twoId);
  }

  sendAudioToChats(File file) async {
    // XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    String audioUrl =
        await FirestorgeHelper.firestorgeHelper.uploadAudio(File(file.path));
    FirestoreHelper.firestoreHelper.addMessageToFirestore({
      'userId': this.myId,
      'dateTime': DateTime.now(),
      'audioUrl': audioUrl
    });
  }

  logout() async {
    await AuthHelper.authHelper.logout();
    RouteHelper.routeHelper.goToPageWithReplacement(Login.routeName);
  }
}
