import 'package:image_picker/image_picker.dart';
import 'package:media_record/features/video/presentation/interface/record_video_interface.dart';

class RecordVideoComponent extends RecordVideoInterface {
  @override
  Future<String?> startRecordingVideo(ImageSource source, Duration maxDuration) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(source: source, maxDuration: maxDuration);
    return file?.path;
  }
}