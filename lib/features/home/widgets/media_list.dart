import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';
import 'package:media_record/features/audio/pages/audio_player_screen.dart';
import 'package:media_record/features/home/controllers/media_list_controller.dart';
import 'package:media_record/features/video/pages/video_player_screen.dart';

class MediaList extends StatelessWidget {
  const MediaList({super.key});

  @override
  Widget build(BuildContext context) {
    MediaListController mediaListController = Get.put(MediaListController());
    return Expanded(
      child: Obx(() {
        List<String> mediaList = mediaListController.mediaList;

        if (mediaList.isEmpty) {
          return Center(
            child: Text(
              "Aucun média",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            itemCount: mediaList.length,
            itemBuilder: (BuildContext context, int index) {
              mediaListController.getIndexColors();
              return Card(
                color:
                    StringsRes.colors.elementAt(mediaListController.indexColor),
                child: InkWell(
                  onTap: () {
                    if (mediaList[index].contains("mp4") ||
                        mediaList[index].contains("MOV")) {
                      Get.to(() => VideoPlayerScreen(media: mediaList[index]));
                    } else {
                      Get.to(() => AudioPlayerScreen(media: mediaList[index]));
                    }
                  },
                  child: Center(
                      child: Icon(
                    (mediaList[index].contains("mp4") ||
                            mediaList[index].contains("MOV"))
                        ? Icons.play_arrow_rounded
                        : Icons.music_note,
                    size: 40,
                    color: Colors.white,
                  )),
                ),
              );
            });
      }),
    );
  }
}
