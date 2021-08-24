import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/shared_helper.dart';
import 'package:chat_app_with_firebase/model/countrymodel.dart';
import 'package:chat_app_with_firebase/model/register_request.dart';
import 'package:chat_app_with_firebase/out_services/custom_dialog.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountryFromFirestore();
  }
  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectCity;
  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectedCity(cities.first.toString());
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
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      RegisterRequest registerRequest = RegisterRequest(
          id: userCredential.user.uid,
          email: emailController.text,
          password: passwordController.text,
          city: cityController.text,
          country: countryController.text,
          fName: fNmaeController.text,
          lName: lNameController.text);
      await FirestoreHelper.firestoreHelper.addToFirestore(registerRequest);

      // await AuthHelper.authHelper.verifyEmail();
      // await AuthHelper.authHelper.logout();
      //   tabController.animateTo(1);
    } on Exception catch (e) {
      // TODO
    }
// navigate to login

    resetControllers();
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    await FirestoreHelper.firestoreHelper
        .getUserFirestore(userCredential.user.uid);

    resetControllers();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }
}
