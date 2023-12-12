import 'package:flutter/material.dart';

abstract class StringsRes {
  static String get buttonTextVideo => 'Video';
  static String get buttonTextAudio => 'Audio';

  static const colors = [
    Color(0xFFCBEEE4),
    Color(0xFFFFE9D9),
    Color(0xFFF4F0E7),
    Color(0xFFEAF5E0),
    Color(0xFFFFD4D3),
    Color(0xFFFFE6BF),
  ];

  static List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];
}
