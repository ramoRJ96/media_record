import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_record/core/constants.dart';
import 'package:media_record/features/audio/presentation/component/record_audio_component.dart';
import 'package:media_record/features/home/presentation/controllers/media_list_controller.dart';
import 'package:media_record/features/home/presentation/pages/home_page.dart';
import 'package:media_record/helper/shared_pref.dart';
import 'package:media_record/main.dart';
import 'package:record/record.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/resources.dart';

class RecordAudioController extends GetxController {
  String audioPath = '';
  final counterStep = 1;

  var countdownTimer = Rxn<Timer>();
  var recordAudioCounter = Constants.recordDuration.obs;
  var isRecording = false.obs;

  late Record audioRecord;

  List<String> pathAudios = <String>[];

  @override
  void onInit() {
    audioRecord = Record();
    super.onInit();
  }

  void startTimer() {
    countdownTimer.value =
        Timer.periodic(Duration(seconds: counterStep), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer.value?.cancel();
  }

  void resetTimer() {
    stopTimer();
    recordAudioCounter.value = Constants.recordDuration;
  }

  void setCountDown() {
    recordAudioCounter--;
    if (recordAudioCounter <= 0) {
      stopAudioRecording();
      stopTimer();
      debugPrint('Record success');
      countdownTimer.value?.cancel();
    }
  }

  var recordAudioComponent = RecordAudioComponent();

  void startAudioRecording() async {
    await recordAudioComponent.startRecordingAudio();
    isRecording.value = true;
    startTimer();
  }

  void stopAudioRecording() async {
    if (isRecording.value) {
      String? path = await recordAudioComponent.stopRecordingAudio();
      if (path != null) {
        await SharedPrefHelper.addMediaInLocalStorage(path);
      }
    }
    isRecording.value = false;
    Get.find<MediaListController>().getMediaFromStorage();
    // audioPath = path!;
    resetTimer();

    final snackBar = SnackBar(
      backgroundColor: MediaColors.snackbarSuccess,
      content: Text(Resources.audioRecordSuccess),
    );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      Get.back();
  }

  Future<void> cancelAudioRecording() async {
    try {
      resetTimer();
      debugPrint('Cancel recording');
      isRecording.value = false;
      final snackBar = SnackBar(
        backgroundColor: MediaColors.snackbarError,
        content: Text(Resources.audioRecordCancel),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    } catch (e) {
      debugPrint('Error Canceling record : $e');
    }
  }

  Future<void> quitAudioRecordingPage() async {
    try {
      resetTimer();
      debugPrint('Quit audio recording page');
      isRecording.value = false;
    } catch (e) {
      debugPrint('Error Canceling record : $e');
    }
  }



  @override
  void onClose() {
    audioRecord.dispose();
    quitAudioRecordingPage();
    super.onClose();
  }
}
