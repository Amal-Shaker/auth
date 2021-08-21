import 'package:flutter/material.dart';

class TextFieldEmail_widget extends StatelessWidget {
  String hintEmail;
  TextEditingController controller;

  TextFieldEmail_widget({this.hintEmail, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
      ),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: TextFormField(
        controller: this.controller,
        decoration:
            InputDecoration(hintText: this.hintEmail, border: InputBorder.none),
      ),
    );
  }
}
