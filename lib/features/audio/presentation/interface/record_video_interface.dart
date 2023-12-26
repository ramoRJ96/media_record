import 'package:image_picker/image_picker.dart';

abstract class RecordVideoInterface {
  Future<bool?> startRecordingVideo(ImageSource source);
}