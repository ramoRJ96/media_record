import 'dart:io';

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

  static List<String> getString(String key, [List<String>? defValue]) {
    return prefs?.getStringList(key) ?? defValue ?? [];
  }

  static Future<bool> setString(String key, List<String> value) async {
    var prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  static Future<void> addMediaInLocalStorage(String filePath) async {
    var medias = getString('medias');
    medias.add(filePath);
    setString('medias', medias);
  }

  static Future<void> deleteMediaInLocalStorage(String filePath) async {
    var medias = getString('medias');
    int index = medias.indexOf(filePath);
    medias.removeAt(index);
    File(filePath).delete();
    setString('medias', medias);
  }
}
