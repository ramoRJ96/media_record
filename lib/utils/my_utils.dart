import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MyUtils {
  static var pathVideos = <String>[];

  static Future<void> onVideoButtonPressed(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(
      source: source, maxDuration: const Duration(seconds: 10)
    );
    if (file != null) {
      GallerySaver.saveVideo(file.path);
      // pathVideos.add(file.path);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList('medias') == null) {
        prefs.setStringList('medias', <String>[]);
      }
      var medias = prefs.getStringList('medias')!;
      medias.add(file.path);
      prefs.setStringList('medias', medias);
      for (int i = 0; i < medias.length; i++) {
        if(await checkFileExists(medias[i])) {
          print(medias[i]);
        }
      }
    }
  }

  static Future<bool> checkFileExists(String path) {
    return File(path).exists();
  }
}