import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<AuthProvider>(context, listen: false).checkLogin();
    });
    return Scaffold(
      body: Container(
        color: Colors.red[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Welcome in',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            Center(
              child: Text(
                '   Chat App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
