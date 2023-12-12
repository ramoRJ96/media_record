import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/features/video/controllers/video_player_controller.dart';

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

  @override
  void initState() {
    videoPlayerController.initializePlayer(widget.media);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        iconSize: 22,
        splashRadius: 22,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF434343),
        ),
        onPressed: () {
          Get.back();
        },
      )),
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
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
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
