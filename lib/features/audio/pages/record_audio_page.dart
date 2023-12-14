import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:media_record/widgets/app_bar_screen.dart';
import '../../../core/constants/strings_res.dart';
import '../controllers/record_audio_controller.dart';

class RecordAudioPage extends StatelessWidget {
  const RecordAudioPage({super.key});

  final _marginBetween = 30.0;
  final _micIconSize = 60.0;

  Widget body({
    required RecordAudioController recordAudioController,
    required BuildContext context,
  }) {
    return SafeArea(
      child: Center(
        child: Obx(() {
          final recordCounter =
              MyUtils.strDigits(recordAudioController.recordAudioCounter.value);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!recordAudioController.isRecording.value)
                Text(
                  StringsRes.pressToStartRecord,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              SizedBox(
                height: _marginBetween,
              ),
              if (recordAudioController.isRecording.value)
                Column(
                  children: [
                    Icon(
                      Icons.mic,
                      size: _micIconSize,
                    ),
                    Text('${StringsRes.hhmm}$recordCounter'),
                    Text(
                      StringsRes.recordLoading,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
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
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RecordAudioController recordAudioController =
        Get.put(RecordAudioController());

    return Scaffold(
        appBar: AppBarScreen(
          title: Text(
            StringsRes.audioRecord,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          enableLeading: true,
        ),
        body: body(
          context: context,
          recordAudioController: recordAudioController,
        ));
  }
}
