import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class VideoPlayerAppController extends GetxController {
  late VideoPlayerController videoPlayerController;
  Rxn<ChewieController> chewieController = Rxn<ChewieController>();
  int? bufferDelay;

  List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  @override
  void onInit() {
    initializePlayer();
    super.onInit();
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await videoPlayerController.pause();
    currPlayIndex += 1;
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    await initializePlayer();
  }

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
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
