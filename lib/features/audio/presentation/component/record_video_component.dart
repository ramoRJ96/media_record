import 'dart:ui';

import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_record/features/audio/presentation/interface/record_video_interface.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../core/resources.dart';
import '../../../../helper/shared_pref.dart';

class RecordVideoComponent extends RecordVideoInterface {

  @override
  Future<bool?> startRecordingVideo(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(source: source, maxDuration: const Duration(seconds: Constants.recordDuration));
    if (file != null) {
      if (await isMediaLessThan10Sec(file.path)) {
        return false;
      }
      await SharedPrefHelper.addMediaInLocalStorage(file.path);
      return true;
    }
    return null;
  }

  Future<bool> isMediaLessThan10Sec(String filePath) async {
    final videoInfo = FlutterVideoInfo();
    VideoData? info = await videoInfo.getVideoInfo(filePath);
    return info?.duration != null &&
        (info!.duration!.round() / 1000).round() < Constants.recordDuration;
  }
}