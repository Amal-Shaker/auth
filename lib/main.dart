import 'package:chat_app_with_firebase/Auth/helper/shared_helper.dart';
import 'package:chat_app_with_firebase/ui/page/HomePage.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:chat_app_with_firebase/ui/page/register.dart';
import 'package:chat_app_with_firebase/ui/page/resetpassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Auth/providers/auth_provider.dart';
import 'out_services/route_helper.dart';

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
          FirebaseConfiguration.routeName: (context) => FirebaseConfiguration()
        },
        navigatorKey: RouteHelper.routeHelper.navKey,
        home: FirebaseConfiguration()
        // home: FirstClass(),
        ),
  ));
}

class FirstClass extends StatefulWidget {
  @override
  _FirstClassState createState() => _FirstClassState();
}

class _FirstClassState extends State<FirstClass> {
  method() async {
    String id = await SharedHelper.sharedHelper.getId();
    print(id);
    if (id == null) {
      // Navigator.of(context).pushReplacement(newRoute)(
      //     MaterialPageRoute(builder: (context) => FirebaseConfiguration()));
      RouteHelper.routeHelper
          .goToPageWithReplacement(FirebaseConfiguration.routeName);

      // Login();
    } else {
      print("id");
      RouteHelper.routeHelper.goToPageWithReplacement(Home.routeName);
    }
  }

  @override
  void initState() {
    Firebase.initializeApp();
    method();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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
            return Login();
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }
}
