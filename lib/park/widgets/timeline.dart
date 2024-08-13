import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Items/arrival_item.dart';
import '../arrivals_provider.dart';
import 'arrival/arrival_icon.dart';
import 'hour_line.dart';

//TODO: need to make a decision about proportions, in the timeline each hour is
// small. but people can't input arrival longer that 1 hour. so we need to
// make a decision about how to represent the time. maybe enlarge the timeline
class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late Timer _timer;
  DateTime _now = DateTime.now();
  late ArrivalsProvider _arrivalsProvider;

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

  //TODO: handle bug with not optimal organization of arrivals
  List<ArrivalIcon> generateArrivalIcons(List<ArrivalItem> arrivals, double hourWidth) {
    // Sort the arrivals by startTime
    arrivals.sort((a, b) => a.startTime.compareTo(b.startTime));

    // List to store the icons
    List<ArrivalIcon> icons = [];

    for (int i = 0; i < arrivals.length; i++) {
      final currentArrival = arrivals[i];

      // Find the maximum row number among overlapping items
      int maxRowNum = 0;
      for (int j = 0; j < i; j++) {
        final previousArrival = arrivals[j];
        // Check if current arrival overlaps with previous arrival
        if (currentArrival.startTime.isBefore(previousArrival.endTime) &&
            currentArrival.endTime.isAfter(previousArrival.startTime)) {
          maxRowNum = previousArrival.rowNum + 1;
        }
      }

      // Assign row number to the current arrival
      currentArrival.rowNum = maxRowNum;

      // Create an ArrivalIcon for the current arrival
      icons.add(
        ArrivalIcon(
          text: currentArrival.dog,
          width: (currentArrival.endTime.difference(currentArrival.startTime).inMinutes / 60.0) * hourWidth,
          startTime: currentArrival.startTime,
          rowNum: currentArrival.rowNum,
        ),
      );
    }

    return icons;
  }

  @override
  Widget build(BuildContext context) {
    _arrivalsProvider = Provider.of<ArrivalsProvider>(context);
    const double hourWidth = 60;

    // Get the list of arrivals from the provider
    // final arrivals = Provider.of<ArrivalsProvider>(context).arrivalItems;

    // Generate the list of ArrivalIcons with adjusted row positions
    // final arrivalIcons = generateArrivalIcons(arrivals, hourWidth);

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
              color: Colors.redAccent,
            ),
          ),
          for (final icon in
          generateArrivalIcons(_arrivalsProvider.arrivalItems, hourWidth))
            Positioned(
              left: ((icon.startTime.hour - _now.hour + 4.5) +
                  icon.startTime.minute / 60.0) *
                  hourWidth,
              top: 50 * (icon.rowNum + 1),
              child: icon,
            ),
        ],
      ),
    );
  }
}
