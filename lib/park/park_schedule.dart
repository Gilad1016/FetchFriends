import 'package:Fetch/park/widgets/time_line.dart';
import 'package:flutter/material.dart';
import '../common/widgets/top_bar/app_bar.dart';
import 'park_item.dart';

class ParkSchedulePage extends StatefulWidget {
  const ParkSchedulePage({super.key});

  @override
  State<ParkSchedulePage> createState() => _ParkSchedulePageState();
}

class _ParkSchedulePageState extends State<ParkSchedulePage> {
  late final List<ParkItem> parkData;

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
    parkData = [];
    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          titleText: 'Sokolov Garden'),
      body: Padding(
        padding: EdgeInsets.only(bottom: 40, left: 28, right: 28),
        child: Timeline(),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: ListView.builder(
        //         itemCount: parkData.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text(parkData[index].name),
        //             onTap: () {
        //             },
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
      // floatingActionButton: const ArrivalButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
