import 'package:fetch/park/park_provider.dart';
import 'package:fetch/park/widgets/arrival/arrival_button.dart';
import 'package:fetch/park/widgets/park_app_bar.dart';
import 'package:fetch/park/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParkSchedulePage extends StatelessWidget {

  const ParkSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final parkProvider = Provider.of<ParkProvider>(context);

    return parkProvider.currentPark.name == '' ?
    Scaffold(
      body: Center(
        child: Image.asset("assets/images/dog_bouncing_ball.gif"),
      ),
    ) :
    const Scaffold(
      appBar: ParkAppBar(),
      body: Timeline(),
      floatingActionButton: ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
