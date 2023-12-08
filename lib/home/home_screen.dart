import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_record/utils/my_utils.dart';

import '../data/constants/strings_res.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVideo = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Text('Bienvenue !'),
          const Text('Choisissez le média à enregistrer : '),

          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      MyUtils.onVideoButtonPressed(ImageSource.camera);
                    },
                    child: Text(StringsRes.buttonTextVideo.toUpperCase()),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(StringsRes.buttonTextAudio.toUpperCase()),
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
