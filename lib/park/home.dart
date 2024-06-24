import 'package:flutter/material.dart';
import '../common/widgets/arrival_tile.dart';
import '../common/widgets/top_bar/app_bar.dart';
import 'park_item.dart';
import '../dog_management/dog_item.dart';

class ParkHomePage extends StatefulWidget {
  const ParkHomePage({super.key});

  @override
  State<ParkHomePage> createState() => _ParkHomePageState();
}

class _ParkHomePageState extends State<ParkHomePage> {
  late final List<DogItem> dogData;

  ParkItem park = ParkItem(
      name: 'Sokolov Garden',
      mapsURL: Uri.parse('https://maps.app.goo.gl/QrmnpJT3EBZEppEMA'));

  onStartUp(BuildContext context) async {
    // _backendService.getDogs().then((data) {
    //   setState(() {
    //     dogData = data!;
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    dogData = [];
    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          titleText: 'Sokolov Garden'),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 28, right: 28),
        child: ListView.builder(
          itemCount: dogData.length,
          itemBuilder: (context, index) {
            final dogItem = dogData[index];
            return ArrivalTile(dogItem: dogItem);
          },
        ),
      ),
      // floatingActionButton: const ArrivalButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
