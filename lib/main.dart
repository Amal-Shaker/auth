import 'package:chat_app_with_firebase/Auth/helper/shared_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/chat/alluser.dart';
import 'package:chat_app_with_firebase/chat/chat_page.dart';
import 'package:chat_app_with_firebase/chat/profile.dart';

import 'package:chat_app_with_firebase/chat/update_profile.dart';
import 'package:chat_app_with_firebase/chat/user.dart';
import 'package:chat_app_with_firebase/ui/page/HomePage.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:chat_app_with_firebase/ui/page/register.dart';
import 'package:chat_app_with_firebase/ui/page/resetpassword.dart';
import 'package:chat_app_with_firebase/ui/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'out_services/route_helper.dart';

//flutter_radio_player  ====> package to play sound
void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Login.routeName: (context) => Login(),
          Register.routeName: (context) => Register(),
          ForgetPass.routeName: (context) => ForgetPass(),
          Home.routeName: (context) => Home(),
          ProfilePage.routeName: (context) => ProfilePage(),
          UpdateProfile.routeName: (context) => UpdateProfile(),
          AllUser.routeName: (context) => AllUser(),
          ChatPage.routeName: (context) => ChatPage(),
          //UserPage.: (context) => UpdateProfile(),

          FirebaseConfiguration.routeName: (context) => FirebaseConfiguration()
        },
        navigatorKey: RouteHelper.routeHelper.navKey,
        home: FirebaseConfiguration()
        //home: Login(),
        ),
  ));
}

// class FirstClass extends StatefulWidget {
//   @override
//   _FirstClassState createState() => _FirstClassState();
// }

// class _FirstClassState extends State<FirstClass> {
//   method() async {
//     String id = await SharedHelper.sharedHelper.getId();
//     print(id);
//     if (id == null) {
//       // Navigator.of(context).pushReplacement(newRoute)(
//       //     MaterialPageRoute(builder: (context) => FirebaseConfiguration()));
//       RouteHelper.routeHelper
//           .goToPageWithReplacement(FirebaseConfiguration.routeName);

//       // Login();
//     } else {
//       print("id");
//       RouteHelper.routeHelper.goToPageWithReplacement(Home.routeName);
//     }
//   }

//   @override
//   void initState() {
//     Firebase.initializeApp();
//     method();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class FirebaseConfiguration extends StatelessWidget {
  static String routeName = 'firebaseConfiguration';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnappshot) {
          if (dataSnappshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnappshot.error.toString()),
              ),
            );
          }
          if (dataSnappshot.connectionState == ConnectionState.done) {
            // return Scaffold(
            //   body: Text('DONE'),
            // );
            return SplashScreen();
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }
}
