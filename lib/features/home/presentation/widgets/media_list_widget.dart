import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:media_record/core/colors.dart';
import 'package:media_record/core/constants.dart';
import 'package:media_record/core/resources.dart';
import 'package:media_record/features/audio/presentation/pages/audio_player_screen.dart';
import 'package:media_record/features/home/presentation/controllers/media_list_controller.dart';
import 'package:media_record/features/home/presentation/pages/home_page.dart';
import 'package:media_record/features/video/presentation/pages/video_player_screen.dart';
import 'package:media_record/helper/shared_pref.dart';

class MediaListWidget extends StatelessWidget {
  MediaListWidget({super.key});

  final MediaListController mediaListController =
      Get.put(MediaListController());

  final gridCrossCount = 2;
  final iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => (mediaListController.mediaList.isEmpty)
          ? Center(
              child: Text(
                Resources.noMedia,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCrossCount,
              ),
              shrinkWrap: true,
              itemCount: mediaListController.mediaList.length,
              itemBuilder: (BuildContext context, int index) {
                mediaListController.getIndexColors();
                bool isMediaVideo = mediaListController.mediaList[index]
                        .contains(Constants.mp4) ||
                    mediaListController.mediaList[index]
                        .contains(Constants.mov);
                IconData icon =
                    isMediaVideo ? Icons.play_arrow_rounded : Icons.music_note;
                return Container(
                  // padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        child: Stack(
                          children: [
                            Card(
                              color: MediaColors.gridViewColors
                                  .elementAt(mediaListController.indexColor),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => isMediaVideo
                                          ? VideoPlayerScreen(
                                              media: mediaListController
                                                  .mediaList[index])
                                          : AudioPlayerScreen(
                                              media: mediaListController
                                                  .mediaList[index]));
                                },
                                child: Center(
                                    child: Icon(
                                  icon,
                                  size: iconSize,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                            Positioned(
                              bottom: 5.0,
                              right: 5.0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black12,
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(Resources.confirmDeletingElement),
                                          Text('${(basename(mediaListController.mediaList[index].replaceAll(RegExp(r'\s*-\s*'), '')))} ?'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: Text(Resources.textCancel),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Get.find<MediaListController>()
                                                .deleteMediaInLocalStorage(
                                                    mediaListController
                                                        .mediaList[index]);
                                            Get.back();
                                            final snackBar = SnackBar(
                                              backgroundColor:
                                                  MediaColors.snackbarSuccess,
                                              content: Text(
                                                  Resources.textElementDeleted),
                                            );
                                            ScaffoldMessenger.of(Get.context!)
                                                .showSnackBar(snackBar);
                                          },
                                          child: Text(Resources.textDelete),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Center(child: Text(basename(mediaListController.mediaList[index].replaceAll(RegExp(r'\s*-\s*'), '')), style: const TextStyle(fontSize: 9), ))),
                    ],
                  ),
                );
              })),
    );
  }
}
