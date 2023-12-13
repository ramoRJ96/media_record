import 'dart:io';

import 'package:chewie_audio/chewie_audio.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AudioPlayerAppController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rxn<ChewieAudioController> chewieController = Rxn<ChewieAudioController>();
  int? bufferDelay;

  /// Initialize all stuffs for the audio player
  /// 
  /// You can use network url or file path for the [media]
  Future<void> initializePlayer(String media) async {
    videoPlayerController = _isNetworkUrl(media)
        ? VideoPlayerController.networkUrl(Uri.parse(media))
        : VideoPlayerController.file(File(media));
    await videoPlayerController.initialize();
    _createChewieController();
    refresh();
  }

  /// Check if the [path] is a network url 
  bool _isNetworkUrl(String path) {
    Uri? uri = Uri.tryParse(path);
    if (uri != null) {
      // If the URI is absolute, it is a network URL
      return uri.isAbsolute;
    }
    return false;
  }

  /// ChewieController has many options to control the audio player
  void _createChewieController() {
    chewieController.value = ChewieAudioController(
      videoPlayerController: videoPlayerController,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
    );
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.value?.dispose();
    super.onClose();
  }
}
