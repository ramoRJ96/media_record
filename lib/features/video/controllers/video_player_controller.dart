import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
// import 'package:media_record/core/constants/strings_res.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class VideoPlayerAppController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rxn<ChewieController> chewieController = Rxn<ChewieController>();
  int? bufferDelay;
  // int currPlayIndex = 0;

  // @override
  // void onInit() {
  //   initializePlayer();
  //   super.onInit();
  // }

  /// Initialization du controlleur de la videoPlayer
  Future<void> initializePlayer(String media) async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(media));
    await videoPlayerController.initialize();
    _createChewieController();
    refresh();
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
  void dispose() {
    videoPlayerController.dispose();
    chewieController.value?.dispose();
    super.dispose();
  }
}
