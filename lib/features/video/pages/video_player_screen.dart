import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';
import 'package:media_record/features/video/controllers/video_player_controller.dart';
import 'package:media_record/widgets/app_bar_screen.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    Key? key,
    required this.media,
  }) : super(key: key);

  final String media;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final VideoPlayerAppController videoPlayerController =
      Get.put(VideoPlayerAppController());
  final _marginBetween = 30.0;

  @override
  void initState() {
    videoPlayerController.initializePlayer(widget.media);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(),
      body: Obx(() {
        return Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: videoPlayerController.chewieController.value != null &&
                        videoPlayerController.chewieController.value!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller:
                            videoPlayerController.chewieController.value!,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: _marginBetween),
                          Text(StringsRes.loading),
                        ],
                      ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
