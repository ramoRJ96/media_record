import 'package:flutter/material.dart';

abstract class StringsRes {
  static String get buttonTextVideo => 'Video';
  static String get buttonTextAudio => 'Audio';
  static String get buttonTextCancelRecording => 'Annuler';
  static String get buttonTextStartRecording => 'Start';
  static String get loading => 'Chargement';
  static String get audioRecord => 'Enregistrement audio';
  static String get pressToStartRecord =>
      'Appuyez sur Start pour commencer l\'enregistrement';
  static String get recordLoading => 'Enregistrement audio en cours';
  static String get hhmm => '00:00:';

  static const colors = [
    Color(0xFFCBEEE4),
    Color(0xFFFFE9D9),
    Color(0xFFF4F0E7),
    Color(0xFFEAF5E0),
    Color(0xFFFFD4D3),
    Color(0xFFFFE6BF),
  ];
}
