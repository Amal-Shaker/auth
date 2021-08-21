import 'package:flutter/material.dart';

class LastContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 120, right: 120),
      height: 6,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
    );
  }
}
