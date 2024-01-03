import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import '../../../../core/constants.dart';
import '../../../../core/resources.dart';
import '../../../../utils/my_utils.dart';
import '../controllers/record_audio_controller.dart';

class RecordAudioWidgets {
  static Widget body({
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
                  Resources.pressToStartRecord,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(
                height: Constants.marginBetween,
              ),
              if (recordAudioController.isRecording.value)
                Column(
                  children: [
                    const Icon(
                      Icons.mic,
                      size: Constants.micIconSize,
                    ),
                    Text('${Resources.hhmm}$recordCounter'),
                    Text(
                      Resources.recordLoading,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ElevatedButton(
                onPressed: recordAudioController.isRecording.value
                    ?
                  recordAudioController.cancelAudioRecording

                    : recordAudioController.startAudioRecording,
                child: recordAudioController.isRecording.value
                    ? Text(Resources.buttonTextCancelRecording)
                    : Text(Resources.buttonTextStartRecording),
              ),
            ],
          );
        }),
      ),
    );
  }
}