import 'package:media_record/core/constants.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

class MyUtils {
  static Future<bool> isMediaLessThan10Sec(String filePath) async {
    final videoInfo = FlutterVideoInfo();
    VideoData? info = await videoInfo.getVideoInfo(filePath);
    return info?.duration != null &&
        (info!.duration!.round() / 1000).round() < Constants.recordDuration;
  }

  static String strDigits(int n) => n.toString().padLeft(2, '0');
}
