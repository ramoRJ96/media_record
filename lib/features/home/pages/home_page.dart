import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_record/core/constants/colors.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:media_record/features/home/widgets/media_list.dart';
import 'package:media_record/widgets/app_bar_screen.dart';
import '../../../core/constants/strings_res.dart';
import 'package:get/get.dart';

import '../../audio/pages/record_audio_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  final _headerGap = 20.0;
  final _buttonsGap = 10.0;

  void _recordVideo(BuildContext context, bool mounted) async {
    bool isRecorded = await MyUtils.onVideoButtonPressed(ImageSource.camera);

    if (!isRecorded) {
      final snackBar = SnackBar(
        backgroundColor: MediaColors.snackbarError,
        content: Text(StringsRes.videoRecordError),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget _recordButton(BuildContext context, bool mounted) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _buttonsGap),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              _recordVideo(context, mounted);
            },
            child: Text(StringsRes.buttonTextVideo.toUpperCase()),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const RecordAudioPage());
            },
            child: Text(StringsRes.buttonTextAudio.toUpperCase()),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, [bool mounted = true]) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: _headerGap),
          child: Text(
            StringsRes.welcome,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Text(
          StringsRes.chooseMediaRecord,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        _recordButton(context, mounted),
        const MediaList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(child: _body(context)),
    );
  }
}
