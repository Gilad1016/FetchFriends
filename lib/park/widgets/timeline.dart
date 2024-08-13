import 'dart:async';
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
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update the current time every minute
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double hourWidth = 60;

    // Get the list of arrivals from the provider
    final arrivals = Provider.of<ArrivalsProvider>(context).arrivalItems;

    // Add hours to the timeline
    final List<Widget> hourLines = [];
    for (int i = 0; i < 24; i++) {
      final String hourLabel = DateFormat('ha')
          .format(DateTime(0, 0, 0, (i + _now.hour - 4) % 24));
      hourLines.add(SizedBox(
        width: hourWidth,
        child: HourLine(hourLabel: hourLabel),
      ));
    }

    // Calculate the position of the current time line
    final double currentHourOffset = (4.5 + _now.minute / 60.0) * hourWidth;

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
          for (final item in arrivals)
            Positioned(
              left: ((item.startTime.hour - _now.hour + 4.5) +
                  item.startTime.minute / 60.0) *
                  (hourWidth),
              top: 50,
              child: ArrivalIcon(
                text: item.dog,
                width: (item.endTime.hour - item.startTime.hour) * hourWidth,
              ),
            ),
        ],
      ),
    );
  }
}
