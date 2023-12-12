import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';

class MediaListController extends GetxController {
  var indexColor = -1.obs;
  var isClicked = false.obs;

  void handleChangeClikedBehavior(bool newValue) {
    isClicked.value = newValue;
  }

  void getIndexColors() {
    indexColor++;
    if (indexColor >= StringsRes.colors.length) {
      indexColor = 0;
    }
  }
}
