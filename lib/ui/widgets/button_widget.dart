import 'package:flutter/material.dart';

class Button_widget extends StatelessWidget {
  String textButton;
  Function function1;
  Button_widget({this.function1, this.textButton});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 300),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.red[400], borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
          child: Text(
            this.textButton,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: this.function1),
    );
  }
}
