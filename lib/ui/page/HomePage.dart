import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static final routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(child: Text('Welome')),
        Center(
          child: RaisedButton(
              child: Text('back'),
              onPressed: () {
                RouteHelper.routeHelper.goToPage(Login.routeName);
              }),
        ),
        Center(
          child: RaisedButton(
              child: Text('allUser'),
              onPressed: () {
                FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
              }),
        )
      ]),
    );
  }
}
