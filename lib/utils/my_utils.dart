import 'package:media_record/core/constants.dart';
import 'package:media_record/helper/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

import '../features/audio/presentation/component/record_video_component.dart';

class MyUtils {
  static Future<bool?> onVideoButtonPressed(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(seconds: Constants.recordDuration));
    if (file != null) {
      if (await isMediaLessThan10Sec(file.path)) {
        return false;
      }
      await SharedPrefHelper.addMediaInLocalStorage(file.path);
      return true;
    }
    return null;
  }

  static Future<bool> isMediaLessThan10Sec(String filePath) async {
    final videoInfo = FlutterVideoInfo();
    VideoData? info = await videoInfo.getVideoInfo(filePath);
    return info?.duration != null &&
        (info!.duration!.round() / 1000).round() < Constants.recordDuration;
  }

  static String strDigits(int n) => n.toString().padLeft(2, '0');
}
