import 'package:dogy_park/widgets/setting_button.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class ParkPage extends StatelessWidget {
  const ParkPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar:  CustomAppBar(
          titleText: 'Sokolov Garden',
          trailingWidget: SettingWidget()
      ),
      body: Center(
        child: Text('Welcome to the Park page'),
      ),
    );
  }
}
