import 'dart:io';

import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerAppController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rxn<ChewieController> chewieController = Rxn<ChewieController>();
  int? bufferDelay;

  /// Initialization du controlleur de la videoPlayer
  Future<void> initializePlayer(String media) async {
    videoPlayerController = _isNetworkUrl(media)
        ? VideoPlayerController.networkUrl(Uri.parse(media))
        : VideoPlayerController.file(File(media));
    await videoPlayerController.initialize();
    _createChewieController();
    refresh();
  }

  /// Check if [path] is a network url
  ///
  /// If the URI is absolute, it is a network URL
  bool _isNetworkUrl(String path) {
    Uri? uri = Uri.tryParse(path);
    if (uri != null) {
      return uri.isAbsolute;
    }
    return false;
  }

  void _createChewieController() {
    chewieController.value = ChewieController(
      videoPlayerController: videoPlayerController,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 5),
    );
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.value?.dispose();
    super.onClose();
  }
}
