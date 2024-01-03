import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/colors.dart';
import 'package:media_record/core/resources.dart';
import 'package:media_record/features/video/presentation/controllers/video_player_controller.dart';

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
  final VideoPlayerAppController videoPlayerAppController =
      Get.put(VideoPlayerAppController());
  final _marginBetween = 30.0;
  final _closeIconRightPosition = 20.0;
  final _closeIconTopPosition = 30.0;
  final _closeIconSize = 35.0;
  final _videoPlayerWidth = Get.width;
  final _videoPlayerHeight = Get.height * .6;

  @override
  void initState() {
    videoPlayerAppController.initializePlayer(widget.media);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<VideoPlayerAppController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                right: _closeIconRightPosition,
                top: _closeIconTopPosition,
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: _closeIconSize,
                    ))),
            Center(
              child: Container(
                color: MediaColors.blackGrey,
                width: _videoPlayerWidth,
                height: _videoPlayerHeight,
                child: videoPlayerAppController.chewieController.value != null &&
                        videoPlayerAppController.chewieController.value!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller:
                            videoPlayerAppController.chewieController.value!,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: _marginBetween),
                          Text(Resources.loading),
                        ],
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
