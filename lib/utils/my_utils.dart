import 'dart:io';
import 'package:get/get.dart';
import 'package:media_record/core/constants/constants.dart';
import 'package:media_record/features/home/controllers/media_list_controller.dart';
import 'package:media_record/helper/shared_pref.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

class MyUtils {
  static var pathVideos = <String>[];

  static Future<bool?> onVideoButtonPressed(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: Constants.recordDuration));

    if (file != null) {
      if (await isMediaLessThan10Sec(file.path)) {
        return false;
      }
      GallerySaver.saveVideo(file.path);
      SharedPrefHelper.addMediaInLocalStorage(file.path);
      var mediaListController = Get.find<MediaListController>();
      await mediaListController.getMediaFromStorage();
      return true;
    }
    return null;
  }

  static Future<bool> isMediaLessThan10Sec(String filePath) async {
    final videoInfo = FlutterVideoInfo();
    VideoData? info = await videoInfo.getVideoInfo(filePath);
    return info?.duration != null &&
        (info!.duration! ~/ 1000) < Constants.recordDuration;
  }

  static Future<bool> checkFileExists(String path) {
    return File(path).exists();
  }

  static String strDigits(int n) => n.toString().padLeft(2, '0');
}
