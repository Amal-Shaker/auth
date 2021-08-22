import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  SharedHelper._();
  static SharedHelper sharedHelper = SharedHelper._();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> id;
  getId() async {
    final SharedPreferences prefs = await _prefs;

    final idd = prefs.getString('id');
    return idd;
  }

  Future<String> setId(String id) async {
    final SharedPreferences prefs = await _prefs;
    this.id = prefs.setString('id', id).then((bool success) {
      return id;
    });
  }
}
