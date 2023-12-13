import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';
import 'package:media_record/features/audio/controllers/audio_player_controller.dart';
import 'package:media_record/widgets/app_bar_screen.dart';

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
  final marginBetween = 20.0;

  @override
  void initState() {
    audioPlayerAppController.initializePlayer(widget.media);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(),
      body: Obx(() {
        var audioPlayerController =
            audioPlayerAppController.chewieController.value;

        return Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: audioPlayerController != null &&
                        audioPlayerController
                            .videoPlayerController.value.isInitialized
                    ? ChewieAudio(
                        controller: audioPlayerController,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: marginBetween),
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
