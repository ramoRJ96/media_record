import 'package:image_picker/image_picker.dart';

abstract class RecordVideoInterface {
  Future<String?> startRecordingVideo(ImageSource source, Duration maxDuration);
}