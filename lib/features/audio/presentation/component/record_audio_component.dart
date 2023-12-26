import 'package:media_record/features/audio/presentation/interface/record_audio_interface.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';

class RecordAudioComponent implements RecordAudioInterface {
  Record audioRecord = Record();

  @override
  Future<void> startRecordingAudio() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
      }
    } catch (e) {
      debugPrint('Error Start Recording : $e');
    }
  }

  @override
  Future<String?> stopRecordingAudio() async {
    try {
      String? path = await audioRecord.stop();
      return path;
    } catch (e) {
      debugPrint('Error Stop Recording : $e');
    }
  }
}
