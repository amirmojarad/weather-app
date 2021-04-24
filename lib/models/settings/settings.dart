import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  bool showMinutely = false;

  Future<void> loadChanges() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('showMinutely') != null)
      showMinutely = prefs.getBool('showMinutely');
  }

  Future<void> saveChanges() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showMinutely', showMinutely);
  }
}
