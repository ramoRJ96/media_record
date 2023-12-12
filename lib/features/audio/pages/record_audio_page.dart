import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordAudioPage extends StatefulWidget {
  const RecordAudioPage({super.key});

  @override
  State<RecordAudioPage> createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {
  late Record audioRecord;
  bool isRecording = false;
  String audioPath = '';
  var pathAudios = <String>[];
  late Timer timer;

  @override
  void initState() {
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    super.dispose();
  }

  Future<void> startAudioRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
        timer = Timer(const Duration(seconds: 10), () {
          stopAudioRecording();
          print('Record success');
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopAudioRecording() async {
    try {
      String? path = await audioRecord.stop();
      // pathAudios.add(path.toString());
      // for (int i = 0; i < pathAudios.length; i++) {
      //   if(await MyUtils.checkFileExists(pathAudios[i])) {
      //     print(pathAudios[i]);
      //   }
      // }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var medias = prefs.getStringList('medias');
      medias?.add(path.toString());
      prefs.setStringList('medias', medias!);
      pathAudios = medias;
      pathAudios.add(path.toString());
      for (int i = 0; i < pathAudios.length; i++) {
        if (await MyUtils.checkFileExists(pathAudios[i])) {
          print(pathAudios[i]);
        }
      }
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error Stop Recording : $e');
    }
  }

  Future<void> cancelAudioRecording() async {
    try {
      timer.cancel();
      print('Cancel recording');
      setState(() {
        isRecording = false;
      });
    } catch (e) {
      print('Error Canceling record : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Record audio'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (isRecording)
                const Column(
                  children: [
                    Icon(
                      Icons.mic,
                      size: 60,
                    ),
                    Text('Recording audio in progress ...'),
                  ],
                ),
              ElevatedButton(
                onPressed:
                    isRecording ? cancelAudioRecording : startAudioRecording,
                child: isRecording
                    ? const Text('Cancel Recording')
                    : const Text('Start Recording'),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ));
  }
}
