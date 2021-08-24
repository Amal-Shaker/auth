class CountryModel {
  String id;

  String name;
  List<dynamic> cities;
  CountryModel(this.name, this.cities);
  CountryModel.fromJson(Map map) {
    this.id = map['id'];
    this.cities = map['cities'];
    this.name = map['name'];
  }
}
