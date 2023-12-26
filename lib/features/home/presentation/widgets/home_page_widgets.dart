import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/features/audio/presentation/component/record_video_component.dart';
import 'package:media_record/features/home/presentation/widgets/media_list_widget.dart';
import 'package:media_record/features/video/presentation/controllers/record_video_controller.dart';
import '../../../../core/constants.dart';
import '../../../../core/resources.dart';
import '../../../audio/presentation/pages/record_audio_page.dart';

class HomePageWidgets {

  static Widget body(BuildContext context, [bool mounted = true]) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: Constants.headerGap),
          child: Text(
            Resources.welcome,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Text(
          Resources.chooseMediaRecord,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        recordButton(context, mounted),
        const MediaListWidget(),
      ],
    );
  }

  static Widget recordButton(BuildContext context, bool mounted) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Constants.buttonsGap),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              RecordVideoController.startRecordingVideo(context, mounted);
              // RecordVideoController.recordVideo(context, mounted);
            },
            child: Text(Resources.buttonTextVideo.toUpperCase()),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const RecordAudioPage());
            },
            child: Text(Resources.buttonTextAudio.toUpperCase()),
          ),
        ],
      ),
    );
  }
}