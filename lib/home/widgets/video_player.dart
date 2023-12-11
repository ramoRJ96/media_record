import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/home/controllers/video_player_controller.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    Key? key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreenState();
  }
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final VideoPlayerAppController videoPlayerController =
        Get.put(VideoPlayerAppController());
    return Scaffold(
      appBar: AppBar(),
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
            // if (Platform.isAndroid)
            //   ListTile(
            //     title: const Text("Delay"),
            //     subtitle: DelaySlider(
            //       delay:
            //           _chewieController?.progressIndicatorDelay?.inMilliseconds,
            //       onSave: (delay) async {
            //         if (delay != null) {
            //           bufferDelay = delay == 0 ? null : delay;
            //           await initializePlayer();
            //         }
            //       },
            //     ),
            //   )
          ],
        );
      }),
    );
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;
  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
