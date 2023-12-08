import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class MyUtils {
  static var pathVideos = <String>[];
  static Future<void> onVideoButtonPressed(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickVideo(
      source: source, maxDuration: const Duration(seconds: 10)
    );
    if (file != null) {
      // GallerySaver.saveVideo(file.path);
      pathVideos.add(file.path);
    }
    for (int i = 0; i < pathVideos.length; i++) {
        print(pathVideos[i]);
    }
  }
}