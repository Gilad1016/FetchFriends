import 'package:fetch/park/widgets/arrival/arrival_button.dart';
import 'package:fetch/park/widgets/timeline.dart';
import 'package:flutter/material.dart';
import '../common/widgets/top_bar/app_bar.dart';

class ParkSchedulePage extends StatelessWidget {
  const ParkSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(titleText: 'Sokolov Garden'),
      body: Timeline(), //CircularProgressIndicator(),//
      floatingActionButton: ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}