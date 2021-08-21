import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/register.dart';
import 'package:chat_app_with_firebase/ui/page/resetpassword.dart';
import 'package:chat_app_with_firebase/ui/widgets/appbar.dart';
import 'package:chat_app_with_firebase/ui/widgets/containpage.dart';
import 'package:chat_app_with_firebase/ui/widgets/lastContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static final routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar_widget(),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return Contain_page(
            addrestext1: 'Log in to your ',
            addresstext2: 'account',
            hintemail: 'email',
            hintpassword: 'password',
            buttonText: 'Log in',
            textAfterButton: '',
            rowText1: 'Don\'t have an accounnt?',
            rowText2: 'Sign up',
            forgettext: 'Forget?',
            emailcontroller: provider.emailController,
            passwordcontroller: provider.passwordController,
            forgetFun: () =>
                RouteHelper.routeHelper.goToPage(ForgetPass.routeName),
            function1: provider.login,
            // function1: () => AuthHelper.authHelper.signin(
            //     provider.emailController.text,
            //     provider.passwordController.text),
            function2: () =>
                RouteHelper.routeHelper.goToPage(Register.routeName),
          );
        })

        // body: Container(
        //     margin: EdgeInsets.only(right: 30, left: 30, top: 20),
        //     child: Column(children: <Widget>[
        //       Form(
        //         child: Expanded(
        //           child: ListView(
        //             children: [
        //               Container(
        //                 child: Text(
        //                   'Log in to your ',
        //                   style: TextStyle(
        //                       fontSize: 20,
        //                       color: Colors.red[400],
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               Container(
        //                 margin: EdgeInsets.only(bottom: 40),
        //                 child: Text(
        //                   'account ',
        //                   style: TextStyle(
        //                       fontSize: 20,
        //                       color: Colors.red[400],
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               Container(
        //                 padding: EdgeInsets.only(
        //                   left: 15,
        //                 ),
        //                 margin: EdgeInsets.only(bottom: 10),
        //                 decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(25),
        //                     color: Colors.white),
        //                 child: TextFormField(
        //                   decoration: InputDecoration(
        //                       hintText: 'Email', border: InputBorder.none),
        //                   validator: (String value) {
        //                     if (value.isEmpty ||
        //                         value.indexOf("@") == -1 ||
        //                         value.indexOf(".") == -1) {
        //                       return "enter vaild Email";
        //                     }
        //                     return "";
        //                   },
        //                 ),
        //               ),
        //               Container(
        //                 padding: EdgeInsets.only(left: 15, right: 15),
        //                 margin: EdgeInsets.only(bottom: 10),
        //                 decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(25),
        //                     color: Colors.white),
        //                 child: Row(
        //                   children: [
        //                     Expanded(
        //                       child: TextFormField(
        //                         obscureText: true,
        //                         decoration: InputDecoration(
        //                             hintText: 'Password',
        //                             border: InputBorder.none),
        //                         validator: (String value) {
        //                           if (value.isEmpty || value.length < 1) {
        //                             return "enter password";
        //                           }
        //                           return "";
        //                         },
        //                       ),
        //                     ),
        //                     GestureDetector(
        //                       child: Text(
        //                         'Forget?',
        //                         style: TextStyle(color: Colors.red[400]),
        //                       ),
        //                       onTap: () {
        //                         // Navigator.push(
        //                         //     context,
        //                         //     MaterialPageRoute(
        //                         //         builder: (context) => ForgetPass()));
        //                       },
        //                     )
        //                   ],
        //                 ),
        //               ),
        //               Container(
        //                 margin: EdgeInsets.only(bottom: 300),
        //                 width: MediaQuery.of(context).size.width,
        //                 decoration: BoxDecoration(
        //                     color: Colors.red[400],
        //                     borderRadius: BorderRadius.circular(25)),
        //                 child: MaterialButton(
        //                     child: Text(
        //                       'Log in',
        //                       style:
        //                           TextStyle(color: Colors.white, fontSize: 15),
        //                     ),
        //                     onPressed: () {
        //                       // Navigator.push(
        //                       //     context,
        //                       //     MaterialPageRoute(
        //                       //         builder: (context) => Home()));
        //                     }),
        //               ),
        //               Container(
        //                 margin: EdgeInsets.only(
        //                     bottom: 20, left: 60, right: 60, top: 100),
        //                 child: Row(
        //                   children: [
        //                     Text(
        //                       'Don\'t have an accounnt?',
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     ),
        //                     SizedBox(
        //                       width: 5,
        //                     ),
        //                     GestureDetector(
        //                       child: Text('Sign up',
        //                           style: TextStyle(color: Colors.red[400])),
        //                       onTap: () {
        //                         // Navigator.push(
        //                         //     context,
        //                         //     MaterialPageRoute(
        //                         //         builder: (context) => Register()));
        //                       },
        //                     )
        //                   ],
        //                 ),
        //               ),
        //               LastContainer(),
        //             ],
        //           ),
        //         ),
        //       )
        //     ]))
        );
  }
}
