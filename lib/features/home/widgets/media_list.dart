import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';
import 'package:media_record/features/home/controllers/media_list_controller.dart';

class MediaList extends StatelessWidget {
  const MediaList({super.key});

  @override
  Widget build(BuildContext context) {
    MediaListController mediaListController = Get.put(MediaListController());
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          shrinkWrap: true,
          itemCount: 300,
          itemBuilder: (BuildContext context, int index) {
            mediaListController.getIndexColors();
            return Card(
              color:
                  StringsRes.colors.elementAt(mediaListController.indexColor),
              child: InkWell(
                onTap: () {},
                child: Center(
                    child: Icon(
                  index % 2 == 0 ? Icons.play_arrow_rounded : Icons.music_note,
                  size: 40,
                  color: Colors.white,
                )),
              ),
            );
          }),
    );
  }
}
