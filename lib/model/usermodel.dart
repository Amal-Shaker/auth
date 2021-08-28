import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String city;
  String country;
  String fName;
  String lName;
  String imageUrl;
  UserModel(
      {this.id,
      this.email,
      this.city,
      this.country,
      this.fName,
      this.lName,
      this.imageUrl});

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.city = map['city'];
    this.country = map['country'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.imageUrl = map['imageUrl'];
  }
  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'city': this.city,
      'country': this.country,
      'fName': this.fName,
      'lName': this.lName,
      'imageUrl': this.imageUrl
    };
  }
}
