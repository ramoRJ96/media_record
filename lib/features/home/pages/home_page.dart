import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:media_record/features/home/widgets/media_list.dart';
import 'package:media_record/widgets/app_bar_screen.dart';
import '../../../core/constants/strings_res.dart';
import 'package:get/get.dart';

import '../../audio/pages/record_audio_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  final headerGap = 20.0;
  final buttonsGap = 10.0;

  Widget _recordButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: buttonsGap),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              MyUtils.onVideoButtonPressed(ImageSource.camera);
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

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: headerGap),
          child: Text(
            StringsRes.welcome,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Text(
          StringsRes.chooseMediaRecord,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        _recordButton(),
        const MediaList(),
        const SizedBox(
          height: 40,
        )
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
      body: _body(context),
    );
  }
}
