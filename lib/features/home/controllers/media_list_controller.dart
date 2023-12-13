import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    mediaList.value = prefs.getStringList('medias') ?? [];
  }

  void getIndexColors() {
    indexColor++;
    if (indexColor >= StringsRes.colors.length) {
      indexColor = 0;
    }
  }
}
