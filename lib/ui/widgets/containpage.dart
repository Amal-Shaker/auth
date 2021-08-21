import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/ui/widgets/button_widget.dart';
import 'package:chat_app_with_firebase/ui/widgets/lastContainer.dart';
import 'package:chat_app_with_firebase/ui/widgets/textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contain_page extends StatelessWidget {
  String addrestext1;
  String addresstext2;
  String hintemail;
  String hintpassword;
  String buttonText;
  String textAfterButton;
  String rowText1;
  String rowText2;
  String forgettext;
  Function forgetFun;
  Function function1;
  Function function2;
  TextEditingController emailcontroller;
  TextEditingController passwordcontroller;

  Contain_page(
      {this.addresstext2,
      this.addrestext1,
      this.buttonText,
      this.function1,
      this.function2,
      this.hintemail,
      this.hintpassword,
      this.rowText1,
      this.rowText2,
      this.textAfterButton,
      this.forgetFun,
      this.forgettext,
      this.emailcontroller,
      this.passwordcontroller});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Container(
        margin: EdgeInsets.only(right: 30, left: 30, top: 20),
        child: Column(
          children: <Widget>[
            Form(
                child: Expanded(
              child: ListView(
                children: [
                  Container(
                    child: Text(
                      addrestext1,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Text(
                      addresstext2,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFieldEmail_widget(
                    hintEmail: hintemail,
                    controller: this.emailcontroller,
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(
                  //     left: 15,
                  //   ),
                  //   margin: EdgeInsets.only(bottom: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25),
                  //       color: Colors.white),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //         hintText: hintemail, border: InputBorder.none),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: this.passwordcontroller,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: hintpassword,
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                            child: Text(
                              forgettext,
                              style: TextStyle(color: Colors.red[400]),
                            ),
                            onTap: forgetFun
                            //() {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ForgetPass()));
                            //  },
                            )
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(
                  //     left: 15,
                  //   ),
                  //   margin: EdgeInsets.only(bottom: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25),
                  //       color: Colors.white),
                  //   child: TextFormField(
                  //     obscureText: true,
                  //     decoration: InputDecoration(
                  //         hintText: hintpassword, border: InputBorder.none),
                  //   ),
                  // ),
                  Button_widget(
                    textButton: buttonText,
                    function1: function1,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 40),
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //       color: Colors.red[400],
                  //       borderRadius: BorderRadius.circular(25)),
                  //   child: MaterialButton(
                  //       child: Text(
                  //         buttonText,
                  //         style: TextStyle(color: Colors.white, fontSize: 15),
                  //       ),
                  //       onPressed: function1),
                  // ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 20),
                    child: Text(
                      textAfterButton,
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  )
                ],
              ),
            )),
            Container(
              //   bottom: 20, left: 60, right: 60, top: 100),
              margin: EdgeInsets.only(bottom: 60, left: 60, right: 60),
              child: Row(
                children: [
                  Text(
                    rowText1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      child: Text(rowText2,
                          style: TextStyle(color: Colors.red[400])),
                      onTap: function2
                      //() {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Login()));
                      // },
                      )
                ],
              ),
            ),
            LastContainer(),
          ],
        ),
      );
    });
  }
}
