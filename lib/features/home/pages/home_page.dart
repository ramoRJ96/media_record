import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:media_record/features/home/widgets/media_list.dart';
import '../../../core/constants/strings_res.dart';
import 'package:get/get.dart';

import '../../audio/pages/record_audio_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVideo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Text('Bienvenue !'),
          const Text('Choisissez le média à enregistrer : '),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
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
          ),
          const MediaList(),
          const SizedBox(
            height: 40,
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
