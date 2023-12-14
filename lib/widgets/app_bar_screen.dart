import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/core/constants/colors.dart';
import 'package:media_record/features/home/presentation/controllers/media_list_controller.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarScreen({super.key, this.title, this.enableLeading = false});

  final Widget? title;
  final bool enableLeading;

  final leadingSize = 22.0;
  final leadingSplashRadius = 22.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: title,
        leading: enableLeading
            ? IconButton(
                iconSize: leadingSize,
                splashRadius: leadingSplashRadius,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MediaColors.blackGrey,
                ),
                onPressed: () async {
                  var mediaListController = Get.find<MediaListController>();
                  await mediaListController.getMediaFromStorage();
                  Get.back();
                },
              )
            : null);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
