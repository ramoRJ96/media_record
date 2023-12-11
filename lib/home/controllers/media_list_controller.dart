import 'package:get/get.dart';
import 'package:media_record/data/constants/strings_res.dart';

class MediaListController extends GetxController {
  var indexColor = -1.obs;

  void getIndexColors() {
    indexColor++;
    if (indexColor >= StringsRes.colors.length) {
      indexColor = 0;
    }
  }
}
