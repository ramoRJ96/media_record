import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_record/utils/my_utils.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/strings_res.dart';


class RecordAudioPage extends StatefulWidget {
  const RecordAudioPage({super.key});

  @override
  State<RecordAudioPage> createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {
  Timer? countdownTimer;
  Duration recordAudioDuration = const Duration(seconds: 10);
  late Record audioRecord;
  bool isRecording = false;
  String audioPath = '';
  List<String> pathAudios = <String>[];
   late Timer timer;
  final box = GetStorage();

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  
  void stopTimer() {
    setState(() {
      countdownTimer!.cancel();
    });
  }
  
  void resetTimer() {
    stopTimer();
    setState(() {
      recordAudioDuration = const Duration(seconds: 10);
    });
  }
  
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = recordAudioDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        recordAudioDuration = Duration(seconds: seconds);
      }
    });
  }

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
        // resetTimer();
        startTimer();
        timer = Timer(const Duration(seconds: 10), () {
          stopAudioRecording();
          print('Record success');
          stopTimer();
          // resetTimer();
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList('medias') == null) {
        prefs.setStringList('medias', <String>[]);
      }
      var medias = prefs.getStringList('medias')!;
      medias.add(path.toString());
      prefs.setStringList('medias', medias);
      for (int i = 0; i < medias.length; i++) {
        if(await MyUtils.checkFileExists(medias[i])) {
          print(medias[i]);
        }
      }
      setState(() {
        isRecording = false;
        audioPath = path!;
      });

      resetTimer();
    } catch (e) {
      print('Error Stop Recording : $e');
    }
  }

  Future<void> cancelAudioRecording() async {
    try {
      timer.cancel();
      resetTimer();
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
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(recordAudioDuration.inSeconds);
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: const Text('Enregistrement audio', style: TextStyle(fontSize: 16.0),),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(!isRecording)
              const Text('Appuyez sur Start pour commencer l\'enregistrement'),
            if(isRecording)
              Column(children: [
                const Icon(Icons.mic, size: 60.0,),
                Text('00:00:$seconds'),
                const Text('Enregistrement audio en cours'),
              ],),
            ElevatedButton(
              onPressed: isRecording ? cancelAudioRecording : startAudioRecording,
              child: isRecording ? Text(StringsRes.buttonTextCancelRecording) : Text(StringsRes.buttonTextStartRecording),
            ),
            const SizedBox(height: 25.0,),
          ],
        ),
      )
    );
  }
}
