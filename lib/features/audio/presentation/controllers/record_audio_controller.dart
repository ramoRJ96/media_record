import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_record/core/constants.dart';
import 'package:media_record/helper/shared_pref.dart';
import 'package:record/record.dart';
import 'package:get/get.dart';

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

  Future<void> startAudioRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        isRecording.value = true;
        startTimer();
      }
    } catch (e) {
      debugPrint('Error Start Recording : $e');
    }
  }

  void stopAudioRecording() async {
    try {
      String? path = await audioRecord.stop();
      if (path != null) {
        await SharedPrefHelper.addMediaInLocalStorage(path);
      }
      isRecording.value = false;
      audioPath = path!;
      resetTimer();
    } catch (e) {
      debugPrint('Error Stop Recording : $e');
    }
  }

  Future<void> cancelAudioRecording() async {
    try {
      resetTimer();
      debugPrint('Cancel recording');
      isRecording.value = false;
    } catch (e) {
      debugPrint('Error Canceling record : $e');
    }
  }

  @override
  void onClose() {
    audioRecord.dispose();
    cancelAudioRecording();
    super.onClose();
  }
}
