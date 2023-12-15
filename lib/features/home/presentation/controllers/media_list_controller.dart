import 'package:get/get.dart';
import 'package:media_record/core/colors.dart';
import 'package:media_record/helper/shared_pref.dart';

class MediaListController extends GetxController {
  var indexColor =
      -1.obs; // this variable is necessary for the card color in home page
  var mediaList = <String>[].obs;

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
}
