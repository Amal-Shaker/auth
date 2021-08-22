import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/model/usermodel.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static final routeName = 'Home';
  var users = [];
  method() async {
    users = await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    widget.method();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            return Center(child: Text(widget.users[index].fName));
          }),
      // body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Center(child: Text('Welome')),
      //   Center(
      //     child: RaisedButton(
      //         child: Text('back'),
      //         onPressed: () {
      //           RouteHelper.routeHelper.goToPage(Login.routeName);
      //         }),
      //   ),
      //   Center(
      //     child: RaisedButton(
      //         child: Text('allUser'),
      //         onPressed: () async {
      //           var users = await FirestoreHelper.firestoreHelper
      //               .getAllUsersFromFirestore();
      //           print('llllllll${users.length}');
      //         }),
      //   ),
      //   ListView.builder(
      //       itemCount: 1,
      //       itemBuilder: (context, index) {
      //         return Text(widget.users[index].fName);
      //       })
      // ]),
    );
  }
}
