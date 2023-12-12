import 'package:get/get.dart';
import 'package:media_record/core/constants/strings_res.dart';

class MediaListController extends GetxController {
  var indexColor =
      -1.obs; // this variable is necessary for the card color in home page

  void getIndexColors() {
    indexColor++;
    if (indexColor >= StringsRes.colors.length) {
      indexColor = 0;
    }
  }
}
