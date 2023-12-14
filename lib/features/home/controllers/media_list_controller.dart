import 'package:get/get.dart';
import 'package:media_record/core/constants/colors.dart';
import 'package:media_record/features/audio/pages/audio_player_screen.dart';
import 'package:media_record/features/video/pages/video_player_screen.dart';
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
    if (indexColor >= MediaColors.gridViewColors.length) {
      indexColor = 0;
    }
  }

  void goToMediaPlayer(String media, bool isMediaVideo) {
    if (isMediaVideo) {
      Get.to(() => VideoPlayerScreen(media: media));
    } else {
      Get.to(() => AudioPlayerScreen(media: media));
    }
  }
}
