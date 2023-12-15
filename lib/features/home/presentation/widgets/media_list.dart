import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/colors.dart';
import 'package:media_record/core/constants.dart';
import 'package:media_record/core/resources.dart';
import 'package:media_record/features/audio/presentation/pages/audio_player_screen.dart';
import 'package:media_record/features/home/presentation/controllers/media_list_controller.dart';
import 'package:media_record/features/video/presentation/pages/video_player_screen.dart';

class MediaList extends StatelessWidget {
  const MediaList({super.key});

  final gridCrossCount = 2;
  final iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    MediaListController mediaListController = Get.put(MediaListController());
    return Expanded(
      child: Obx(() {
        List<String> mediaList = mediaListController.mediaList;

        if (mediaList.isEmpty) {
          return Center(
            child: Text(
              Resources.noMedia,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossCount,
            ),
            shrinkWrap: true,
            itemCount: mediaList.length,
            itemBuilder: (BuildContext context, int index) {
              mediaListController.getIndexColors();
              bool isMediaVideo = mediaList[index].contains(Constants.mp4) ||
                  mediaList[index].contains(Constants.mov);
              IconData icon =
                  isMediaVideo ? Icons.play_arrow_rounded : Icons.music_note;
              return Card(
                color: MediaColors.gridViewColors
                    .elementAt(mediaListController.indexColor),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => isMediaVideo
                            ? VideoPlayerScreen(media: mediaList[index])
                            : AudioPlayerScreen(media: mediaList[index]));
                  },
                  child: Center(
                      child: Icon(
                    icon,
                    size: iconSize,
                    color: Colors.white,
                  )),
                ),
              );
            });
      }),
    );
  }
}
