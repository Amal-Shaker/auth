import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<AuthProvider>(context, listen: false).checkLogin();
    });
    return Scaffold(
      body: Center(
        child: Text('splash page'),
      ),
    );
  }
}
