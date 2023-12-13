import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void addMediaInLocalStorage(String filePath) {
    if (prefs.getStringList('medias') == null) {
      prefs.setStringList('medias', <String>[]);
    }
    var medias = prefs.getStringList('medias')!;
    medias.add(filePath);
    prefs.setStringList('medias', medias);
  }
}
