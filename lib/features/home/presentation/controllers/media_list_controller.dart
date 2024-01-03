import 'package:media_record/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:media_record/core/colors.dart';
import 'package:media_record/helper/shared_pref.dart';
import 'dart:io';

class MediaListController extends GetxController {
  var indexColor =
      -1.obs; // this variable is necessary for the card color in home page
  RxList<String> mediaList = <String>[].obs;

  @override
  void onInit() async {
    await getMediaFromStorage();
    super.onInit();
  }

  Future<void> getMediaFromStorage() async {
    mediaList.value = SharedPrefHelper.getString('medias');
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
}
