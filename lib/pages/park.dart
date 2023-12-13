import 'package:dogy_park/widgets/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';
import '../widgets/app_bar.dart';

class ParkPage extends StatelessWidget {
  const ParkPage({super.key});

  @override
  Widget build(BuildContext context) {
  //get dog data from data_provider
  final dogProvider = Provider.of<DataProvider>(context);
  final dogs = dogProvider.getUserDogs(false);
    
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
