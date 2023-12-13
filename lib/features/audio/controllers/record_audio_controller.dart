import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:record/record.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordAudioController extends GetxController {
  var countdownTimer = Rxn<Timer>();
  var recordAudioDuration = const Duration(seconds: 10).obs;
  late Record audioRecord;
  var isRecording = false.obs;
  String audioPath = '';
  List<String> pathAudios = <String>[];
  late Timer timer;

  @override
  void onInit() {
    audioRecord = Record();
    super.onInit();
  }

  void startTimer() {
    countdownTimer.value =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer.value?.cancel();
  }

  void resetTimer() {
    stopTimer();
    recordAudioDuration.value = const Duration(seconds: 10);
  }

  void setCountDown() {
    int reduceSecondsBy = 1;
    final seconds = recordAudioDuration.value.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer.value?.cancel();
    } else {
      recordAudioDuration.value = Duration(seconds: seconds);
    }
  }

  Future<void> startAudioRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        isRecording.value = true;

        startTimer();
        timer = Timer(const Duration(seconds: 10), () {
          stopAudioRecording();
          debugPrint('Record success');
          stopTimer();
          // resetTimer();
        });
      }
    } catch (e) {
      debugPrint('Error Start Recording : $e');
    }
  }

  void stopAudioRecording() async {
    try {
      String? path = await audioRecord.stop();
      // pathAudios.add(path.toString());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList('medias') == null) {
        prefs.setStringList('medias', <String>[]);
      }
      var medias = prefs.getStringList('medias')!;
      medias.add(path.toString());
      prefs.setStringList('medias', medias);
      for (int i = 0; i < medias.length; i++) {
        if (await MyUtils.checkFileExists(medias[i])) {
          debugPrint(medias[i]);
        }
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
      timer.cancel();
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
    super.onClose();
  }
}
