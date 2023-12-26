import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_record/features/audio/presentation/widgets/record_audio_widgets.dart';
import 'package:media_record/widgets/app_bar_screen.dart';
import '../../../../core/resources.dart';
import '../controllers/record_audio_controller.dart';

class RecordAudioPage extends StatelessWidget {
  const RecordAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordAudioController recordAudioController =
        Get.put(RecordAudioController());

    return Scaffold(
        appBar: AppBarScreen(
          title: Text(
            Resources.audioRecord,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          enableLeading: true,
        ),
        body: RecordAudioWidgets.body(
          context: context,
          recordAudioController: recordAudioController,
        ));
  }
}
