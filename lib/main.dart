import 'package:flutter/material.dart';
import 'package:media_record/core/resources.dart';
import 'package:media_record/features/home/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'helper/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Resources.materialAppTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(title: Resources.homeAppBarTitle),
    );
  }
}