class RegisterRequest {
  String id;
  String email;
  String password;
  String city;
  String country;
  String fName;
  String lName;
  String imageUrl;
  RegisterRequest(
      {this.id,
      this.email,
      this.password,
      this.city,
      this.country,
      this.fName,
      this.lName,
      this.imageUrl});

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
