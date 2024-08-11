import 'package:Fetch/park/Items/arrival_item.dart';
import 'package:Fetch/park/arrivals_provider.dart';
import 'package:Fetch/park/widgets/arrival/arrival_button.dart';
import 'package:Fetch/park/widgets/time_line.dart';
import 'package:flutter/material.dart';
import '../common/widgets/top_bar/app_bar.dart';
import 'package:provider/provider.dart';

class ParkSchedulePage extends StatefulWidget {
  const ParkSchedulePage({super.key});

  @override
  State<ParkSchedulePage> createState() => _ParkSchedulePageState();
}

class _ParkSchedulePageState extends State<ParkSchedulePage> {
  late ArrivalsProvider _arrivalsProvider;
  late List<ArrivalItem> arrivals;

  onStartUp(BuildContext context) async {
    _arrivalsProvider = Provider.of<ArrivalsProvider>(context, listen: false);
    arrivals = _arrivalsProvider.arrivalItems;
  }

  @override
  void initState() {
    super.initState();
    arrivals = [];
    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          titleText: 'Sokolov Garden'),
      body: Timeline(),
      floatingActionButton: ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
