abstract class RecordAudioInterface {
  Future<void> startRecordingAudio();
  Future<String?> stopRecordingAudio();
}