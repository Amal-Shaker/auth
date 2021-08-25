import 'package:chat_app_with_firebase/Auth/helper/shared_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/out_services/custom_dialog.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print("frommmm auth helper${userCredential.user.uid}");
      return userCredential;

      // print(userCredential.user.uid);

      // await SharedHelper.sharedHelper.setId(userCredential.user.uid);
      // print(
      //     "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${await SharedHelper.sharedHelper.getId()}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialoug.customDialoug
            .showCustomDialoug('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialoug.customDialoug
            .showCustomDialoug('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signin(String email, String password) async {
    // UserCredential userCredential = await firebaseAuth
    //     .signInWithEmailAndPassword(email: email, password: password);
    // print(await userCredential.user.getIdToken());
    // print(userCredential.user.uid);

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();

      if (isVerifiedEmail) {
        RouteHelper.routeHelper.goToPageWithReplacement(Home.routeName);
      } else {
        CustomDialoug.customDialoug.showCustomDialoug(
            'You have to verify your email, press ok to send another email',
            sendVericiafion());
      }
      return userCredential;
      // RouteHelper.routeHelper.goToPage(Home.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        CustomDialoug.customDialoug
            .showCustomDialoug('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        CustomDialoug.customDialoug
            .showCustomDialoug('Wrong password provided for that user.');
      }
    }
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialoug.customDialoug.showCustomDialoug(
        'we have sent email for reset password, please check your email');
  }

  verifyEmail() async {
    await firebaseAuth.currentUser.sendEmailVerification();
    CustomDialoug.customDialoug.showCustomDialoug(
        'verification email has been sent, please check your email');
  }

  logout() async {
    firebaseAuth.signOut();
  }

  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }
}
