import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/model/countrymodel.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/login.dart';
import 'package:chat_app_with_firebase/ui/widgets/appbar.dart';
import 'package:chat_app_with_firebase/ui/widgets/containpage.dart';
import 'package:chat_app_with_firebase/ui/widgets/lastContainer.dart';
import 'package:chat_app_with_firebase/widget/custom_button.dart';
import 'package:chat_app_with_firebase/widget/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  static final routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar_widget(),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomTextfield('email', provider.emailController),
                CustomTextfield('password', provider.passwordController),
                CustomTextfield('city', provider.cityController),
                CustomTextfield('country', provider.countryController),
                CustomTextfield('fName', provider.fNmaeController),
                CustomTextfield('lName', provider.lNameController),
                provider.countries == null
                    ? Container(
                        child: Text('null'),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton<CountryModel>(
                          isExpanded: true,
                          underline: Container(),
                          value: provider.selectedCountry,
                          onChanged: (x) {
                            provider.selectCountry(x);
                          },
                          items: provider.countries.map((e) {
                            return DropdownMenuItem<CountryModel>(
                              // child: Text(''),
                              child: Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<dynamic>(
                    items: provider.cities.map((e) {
                      return DropdownMenuItem<dynamic>(
                          child: Text(e), value: e);
                    }).toList(),
                    isExpanded: true,
                    underline: Container(),
                    value: provider.selectCity,
                    onChanged: (x) {
                      provider.selectedCity(x);
                    },
                  ),
                ),
                CustomButton(provider.register, 'Register'),
              ],
            ),
          );
          // return Contain_page(
          //   addrestext1: 'Create your',
          //   addresstext2: 'account',
          //   hintemail: 'email',
          //   hintpassword: 'password',
          //   buttonText: 'Sign up',
          //   textAfterButton:
          //       'By clicking Sign up you agree to the our Terms and Conditions',
          //   rowText1: 'Already an account?',
          //   rowText2: 'Logn in',
          //   forgettext: '',
          //   emailcontroller: provider.emailController,
          //   passwordcontroller: provider.passwordController,
          //   function1: provider.register,
          //   function2: () => RouteHelper.routeHelper.goToPage(Login.routeName),
          // );
        })

        // body: Container(
        //   margin: EdgeInsets.only(right: 30, left: 30, top: 20),
        //   child: Column(
        //     children: <Widget>[
        //       Form(
        //           child: Expanded(
        //         child: ListView(
        //           children: [
        //             Container(
        //               child: Text(
        //                 'Create your ',
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     color: Colors.red[400],
        //                     fontWeight: FontWeight.bold),
        //               ),
        //             ),
        //             Container(
        //               margin: EdgeInsets.only(bottom: 40),
        //               child: Text(
        //                 'account ',
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     color: Colors.red[400],
        //                     fontWeight: FontWeight.bold),
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.only(
        //                 left: 15,
        //               ),
        //               margin: EdgeInsets.only(bottom: 10),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(25),
        //                   color: Colors.white),
        //               child: TextFormField(
        //                 decoration: InputDecoration(
        //                     hintText: 'Email', border: InputBorder.none),
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.only(
        //                 left: 15,
        //               ),
        //               margin: EdgeInsets.only(bottom: 10),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(25),
        //                   color: Colors.white),
        //               child: TextFormField(
        //                 obscureText: true,
        //                 decoration: InputDecoration(
        //                     hintText: 'Password', border: InputBorder.none),
        //               ),
        //             ),
        //             Container(
        //               margin: EdgeInsets.only(bottom: 40),
        //               width: MediaQuery.of(context).size.width,
        //               decoration: BoxDecoration(
        //                   color: Colors.red[400],
        //                   borderRadius: BorderRadius.circular(25)),
        //               child: MaterialButton(
        //                   child: Text(
        //                     'Sign up',
        //                     style: TextStyle(color: Colors.white, fontSize: 15),
        //                   ),
        //                   onPressed: () {}),
        //             ),
        //             Container(
        //               margin: EdgeInsets.only(left: 30, right: 20),
        //               child: Text(
        //                 'By clicking Sign up you agree to the our Terms and Conditions',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       )),
        //       Container(
        //         margin: EdgeInsets.only(bottom: 60, left: 70, right: 70),
        //         child: Row(
        //           children: [
        //             Text(
        //               'Already an account?',
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             GestureDetector(
        //               child: Text('Logn in',
        //                   style: TextStyle(color: Colors.red[400])),
        //               onTap: () {
        //                 // Navigator.push(context,
        //                 //     MaterialPageRoute(builder: (context) => Login()));
        //               },
        //             )
        //           ],
        //         ),
        //       ),
        //       LastContainer(),
        //     ],
        //   ),
        // ),
        );
  }
}
