import 'dart:io';

import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestorage_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/shared_helper.dart';
import 'package:chat_app_with_firebase/chat/profile.dart';
import 'package:chat_app_with_firebase/model/countrymodel.dart';
import 'package:chat_app_with_firebase/model/register_request.dart';
import 'package:chat_app_with_firebase/model/usermodel.dart';
import 'package:chat_app_with_firebase/out_services/custom_dialog.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/HomePage.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountryFromFirestore();
  }
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
    RouteHelper.routeHelper.goToPage(ProfilePage.routeName);
    print("pppppppppppppppppppppp${userCredential.user.uid}");

    await FirestoreHelper.firestoreHelper
        .getAllUserFromFirestore(userCredential.user.uid);

    resetControllers();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text.trim());
    resetControllers();
  }

  checkLogin() {
    bool isLogining = AuthHelper.authHelper.checkLogin();
    if (isLogining) {
      RouteHelper.routeHelper.goToPageWithReplacement(ProfilePage.routeName);
    } else {
      RouteHelper.routeHelper.goToPageWithReplacement(Login.routeName);
    }
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
}
