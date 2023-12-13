import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/features/audio/controllers/audio_player_controller.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({
    Key? key,
    required this.media,
  }) : super(key: key);

  final String media;

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayerAppController audioPlayerAppController =
      Get.put(AudioPlayerAppController());

  @override
  void initState() {
    audioPlayerAppController.initializePlayer(widget.media);
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
                child: audioPlayerAppController.chewieController.value !=
                            null &&
                        audioPlayerAppController.chewieController.value!
                            .videoPlayerController.value.isInitialized
                    ? ChewieAudio(
                        controller:
                            audioPlayerAppController.chewieController.value!,
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
