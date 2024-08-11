import 'package:Fetch/park/widgets/time_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Items/arrival_item.dart';


class TimelineWithArrivals extends StatefulWidget {
  const TimelineWithArrivals({super.key});

  @override
  State<TimelineWithArrivals> createState() => _TimelineWithArrivalsState();
}

class _TimelineWithArrivalsState extends State<TimelineWithArrivals> {
  final List<ArrivalItem> arrivalItems = [];

  void addArrivalItem(ArrivalItem item) {
    setState(() {
      arrivalItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Timeline(),
        Positioned(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (final item in arrivalItems)
                Positioned(
                  left: (item.startTime.hour + item.startTime.minute / 60.0) *
                      MediaQuery.of(context).size.width / 6,
                  bottom: 0,
                  child: Container(
                    width: 5.0,
                    color: Colors.blue, // Different color for each arrival
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}