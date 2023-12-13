import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/features/home/controllers/media_list_controller.dart';
import 'package:media_record/utils/my_utils.dart';
import '../../../core/constants/strings_res.dart';
import '../controllers/record_audio_controller.dart';

class RecordAudioPage extends StatelessWidget {
  const RecordAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordAudioController recordAudioController =
        Get.put(RecordAudioController());

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              'Enregistrement audio',
              style: TextStyle(fontSize: 16.0),
            ),
            leading: IconButton(
              iconSize: 22,
              splashRadius: 22,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF434343),
              ),
              onPressed: () async {
                var mediaListController = Get.find<MediaListController>();
                await mediaListController.getMediaFromStorage();
                Get.back();
              },
            )),
        body: Center(
          child: Obx(() {
            final seconds = MyUtils.strDigits(
                recordAudioController.recordAudioDuration.value.inSeconds);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!recordAudioController.isRecording.value)
                  const Text(
                      'Appuyez sur Start pour commencer l\'enregistrement'),
                if (recordAudioController.isRecording.value)
                  Column(
                    children: [
                      const Icon(
                        Icons.mic,
                        size: 60.0,
                      ),
                      Text('00:00:$seconds'),
                      const Text('Enregistrement audio en cours'),
                    ],
                  ),
                ElevatedButton(
                  onPressed: recordAudioController.isRecording.value
                      ? recordAudioController.cancelAudioRecording
                      : recordAudioController.startAudioRecording,
                  child: recordAudioController.isRecording.value
                      ? Text(StringsRes.buttonTextCancelRecording)
                      : Text(StringsRes.buttonTextStartRecording),
                ),
                const SizedBox(
                  height: 25.0,
                ),
              ],
            );
          }),
        ));
  }
}
