import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../arrivals_provider.dart';
import 'arrival/arrival_icon.dart';
import 'hour_line.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    const double hourWidth = 60;
    final now = DateTime.now();

    // Get the list of arrivals from the provider
    final arrivals = Provider.of<ArrivalsProvider>(context).arrivalItems;//TODO: get only the next 20 hours and previous 4 hours

    // Add hours to the timeline
    final List<Widget> hourLines = [];
    for (int i = 0; i < 24; i++) {
      final String hourLabel = DateFormat('ha').format(DateTime(0, 0, 0, i));
      hourLines.add(SizedBox(
        width: hourWidth - 1,
        child: HourLine(hourLabel: hourLabel),
      ));
    }

    // Calculate the position of the current time line
    final double currentHourOffset = now.hour +
        (now.hour + now.minute / 60.0) * hourWidth;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: [
          Row(
            children: hourLines,
          ),
          // Current time indicator
          Positioned(
            left: currentHourOffset,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5.0,
              color: Colors.red,
            ),
          ),
          // Position the arrival items on the timeline
          for (final item in arrivals)
            Positioned(
              left: item.startTime.hour + (item.startTime.hour + item.startTime.minute / 60.0) *
                  hourWidth,
              bottom: 0,
              child: ArrivalIcon(text: item.id, width: (item.endTime.hour - item.startTime.hour) * hourWidth),
            ),
        ],
      ),
    );
  }
}
