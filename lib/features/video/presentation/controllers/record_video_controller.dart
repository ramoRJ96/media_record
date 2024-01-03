import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../core/resources.dart';
import '../../../../helper/shared_pref.dart';
import '../../../../utils/my_utils.dart';
import '../component/record_video_component.dart';
import '../../../home/presentation/controllers/media_list_controller.dart';

class RecordVideoController {
  static void startRecordingVideo (BuildContext context, bool mounted) async {
    var recordVideoComponent = RecordVideoComponent();
    String? videoPath = await recordVideoComponent.startRecordingVideo(ImageSource.camera, const Duration(seconds: Constants.recordDuration));
    bool? isRecorded;
    if (videoPath != null) {
      if (await MyUtils.isMediaLessThan10Sec(videoPath)) {
        isRecorded = false;
      } else {
        await SharedPrefHelper.addMediaInLocalStorage(videoPath);
        isRecorded = true;
      }
    }
    String snackbarText = Resources.videoRecordError;
    Color snackbarBackgroundColor = MediaColors.snackbarError;

    if (isRecorded != null) {
      snackbarText = isRecorded
          ? Resources.videoRecordSuccess
          : Resources.videoRecordNotExactly10Sec;
      snackbarBackgroundColor =
      isRecorded ? MediaColors.snackbarSuccess : MediaColors.snackbarError;
      if (isRecorded) {
        await Get.find<MediaListController>().getMediaFromStorage();
      }
    } else {
      snackbarText = Resources.videoRecordCancel;
    }

    final snackBar = SnackBar(
      backgroundColor: snackbarBackgroundColor,
      content: Text(snackbarText),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}