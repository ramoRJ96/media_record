import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../core/resources.dart';
import '../../../../utils/my_utils.dart';
import '../../../audio/presentation/component/record_video_component.dart';
import '../../../home/presentation/controllers/media_list_controller.dart';

class RecordVideoController {
    static void recordVideo(BuildContext context, bool mounted) async {
    // bool? isRecorded = await MyUtils.onVideoButtonPressed();
    bool? isRecorded = await MyUtils.onVideoButtonPressed(ImageSource.camera);
    String snackbarText = Resources.videoRecordError;
    Color snackbarBackgroundColor = MediaColors.snackbarError;

    if (isRecorded != null) {
      snackbarText = isRecorded
          ? Resources.videoRecordSuccessfully
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

  static void startRecordingVideo (BuildContext context, bool mounted) async {
    var recordVideoComponent = RecordVideoComponent();
    bool? isRecorded = await recordVideoComponent.startRecordingVideo(ImageSource.camera);
    String snackbarText = Resources.videoRecordError;
    Color snackbarBackgroundColor = MediaColors.snackbarError;

    if (isRecorded != null) {
      snackbarText = isRecorded
          ? Resources.videoRecordSuccessfully
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