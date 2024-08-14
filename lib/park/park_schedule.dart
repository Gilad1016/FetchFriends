import 'package:fetch/park/park_provider.dart';
import 'package:fetch/park/widgets/arrival/arrival_button.dart';
import 'package:fetch/park/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/widgets/top_bar/app_bar.dart';

class ParkSchedulePage extends StatelessWidget {

  const ParkSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final parkProvider = Provider.of<ParkProvider>(context);

    return parkProvider.currentPark.name == '' ?
    const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) :
    Scaffold(
      appBar: CustomAppBar(titleText: parkProvider.currentPark.name),
      body: const Timeline(),
      floatingActionButton: const ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
