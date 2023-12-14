import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/resources.dart';
import 'package:media_record/features/audio/presentation/controllers/audio_player_controller.dart';

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
  final AudioPlayerAppController _audioPlayerAppController =
      Get.put(AudioPlayerAppController());
  final _marginBetween = 20.0;
  final _closeIconRightPosition = 20.0;
  final _closeIconTopPosition = 30.0;
  final _closeIconSize = 35.0;
  final _videoPlayerWidth = Get.width;
  final _videoPlayerHeight = Get.height * .6;

  @override
  void initState() {
    _audioPlayerAppController.initializePlayer(widget.media);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var audioPlayerController =
          _audioPlayerAppController.chewieController.value;

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
                      Get.delete<AudioPlayerAppController>();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: _closeIconSize,
                    ))),
            Center(
              child: SizedBox(
                width: _videoPlayerWidth,
                height: _videoPlayerHeight,
                child: audioPlayerController != null &&
                        audioPlayerController
                            .videoPlayerController.value.isInitialized
                    ? Center(
                        child: ChewieAudio(
                          controller: audioPlayerController,
                        ),
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
