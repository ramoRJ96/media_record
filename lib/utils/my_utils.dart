import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class MyUtils {
  // static var pathVideos = <String>[];

  static var mediasList = <String>[];

  static Future<void> onVideoButtonPressed(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(
      source: source, maxDuration: const Duration(seconds: 10)
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (file != null) {
      GallerySaver.saveVideo(file.path);
      // pathVideos.add(file.path);
      var medias = prefs.getStringList('medias');
      medias?.add(file.path);
      prefs.setStringList('medias', medias!);
      mediasList = medias;
    }
    // for (int i = 0; i < pathVideos.length; i++) {
    //   if(await checkFileExists(pathVideos[i])) {
    //     print(pathVideos[i]);
    //   }
    // }

    for (int i = 0; i < mediasList.length; i++) {
      if(await checkFileExists(mediasList[i])) {
        print(mediasList[i]);
      }
    }
  }

  static Future<bool> checkFileExists(String path) {
    return File(path).exists();
  }
}