import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/ui/widgets/appbar.dart';
import 'package:chat_app_with_firebase/ui/widgets/button_widget.dart';
import 'package:chat_app_with_firebase/ui/widgets/textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPass extends StatelessWidget {
  static final routeName = 'forgetPass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar_widget(),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return Container(
              margin: EdgeInsets.only(right: 30, left: 30, top: 20),
              child: Column(children: <Widget>[
                Form(
                  child: Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: Text(
                            'Forgot password ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            'please enter your email to receive a link',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Text(
                            'to create a new password via email',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        TextFieldEmail_widget(
                          hintEmail: 'Email',
                          controller: provider.emailController,
                        ),
                        Button_widget(
                          textButton: 'save',
                          function1: provider.resetPassword,
                        )
                      ],
                    ),
                  ),
                )
              ]));
        }));
  }
}
