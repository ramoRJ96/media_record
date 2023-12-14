import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/colors.dart';
import 'package:media_record/core/constants/strings_res.dart';
import 'package:media_record/features/home/controllers/media_list_controller.dart';

class MediaList extends StatelessWidget {
  const MediaList({super.key});

  final gridCrossCount = 2;

  @override
  Widget build(BuildContext context) {
    MediaListController mediaListController = Get.put(MediaListController());
    return Expanded(
      child: Obx(() {
        List<String> mediaList = mediaListController.mediaList;

        if (mediaList.isEmpty) {
          return Center(
            child: Text(
              StringsRes.noMedia,
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
              bool isMediaVideo = mediaList[index].contains("mp4") ||
                  mediaList[index].contains("MOV");
              IconData icon =
                  isMediaVideo ? Icons.play_arrow_rounded : Icons.music_note;
              return Card(
                color: MediaColors.gridViewColors
                    .elementAt(mediaListController.indexColor),
                child: InkWell(
                  onTap: () {
                    mediaListController.goToMediaPlayer(
                        mediaList[index], isMediaVideo);
                  },
                  child: Center(
                      child: Icon(
                    icon,
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
