import 'package:flutter/material.dart';
import 'package:media_record/features/home/widgets/media_list.dart';
import 'package:media_record/features/video/pages/video_player_screen.dart';

import '../core/constants/strings_res.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VideoPlayerScreen()));
                },
                child: Text(StringsRes.buttonTextVideo.toUpperCase()),
              ),
            ],
          ),
          const MediaList(),
          const SizedBox(
            height: 40,
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
