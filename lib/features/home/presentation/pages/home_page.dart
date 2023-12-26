import 'package:flutter/material.dart';
import 'package:media_record/features/home/presentation/widgets/home_page_widgets.dart';
import 'package:media_record/widgets/app_bar_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(child: HomePageWidgets.body(context)),
    );
  }
}
