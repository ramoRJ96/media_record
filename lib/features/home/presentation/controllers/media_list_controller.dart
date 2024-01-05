import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_record/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:media_record/core/colors.dart';
import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';

class MediaListController extends GetxController {
  var indexColor =
      -1.obs; // this variable is necessary for the card color in home page
  RxList<String> mediaList = <String>[].obs;
  RxList<String> thumbnailsList = <String>[].obs;

  @override
  void onInit() async {
    await getMediaFromStorage();
    super.onInit();
  }

  Future<void> getMediaFromStorage() async {
    mediaList.value = SharedPrefHelper.getString('medias');
    thumbnailsList.value = SharedPrefHelper.getString('videoThumbnailsPath');
  }

  void getIndexColors() {
    indexColor++;
    if (indexColor >= MediaColors.gridViewColors.length) {
      indexColor = 0;
    }
  }

  void deleteMediaInLocalStorage(String filePath) async {
      var medias = SharedPrefHelper.getString('medias');
      int index = medias.indexOf(filePath);
      medias.removeAt(index);
      File(filePath).delete();
      await SharedPrefHelper.setString('medias', medias);
      getMediaFromStorage();
  }

  Future<Uint8List?> _generateThumbnail(String videoPath) async {
    final thumbnailAsUint8List = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
      320, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 50,
    );
    return thumbnailAsUint8List!;
  }

  Future<ImageProvider<Object>>? imageProvider(String videoPath) async {
      final thumbnail = await _generateThumbnail(videoPath);
      return MemoryImage(thumbnail!);
  }
}
