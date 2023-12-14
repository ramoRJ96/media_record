import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

class SharedPrefHelper {
  static SharedPreferences? prefs;
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs!;
  }

  static String getString(String key, [String? defValue]) {
    return prefs?.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static void addMediaInLocalStorage(String filePath) {
    if (prefs?.getStringList('medias') == null) {
      prefs?.setStringList('medias', <String>[]);
    }
    var medias = prefs?.getStringList('medias')!;
    medias?.add(filePath);
    prefs?.setStringList('medias', medias ?? <String>[]);
  }
}
