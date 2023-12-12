import 'package:chewie_audio/chewie_audio.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AudioPlayerAppController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rxn<ChewieAudioController> chewieController = Rxn<ChewieAudioController>();
  int? bufferDelay;

  /// Initialization du controlleur de la videoPlayer
  Future<void> initializePlayer(String media) async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(media));
    await videoPlayerController.initialize();
    _createChewieController();
    refresh();
  }

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