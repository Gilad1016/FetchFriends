import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'hour_line.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  //TODO: adjust such that current time is the center of the screen
  // and we have 20 hours a head of us and 4 hours behind us
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double hourWidth = width / 6;
        final List<Widget> hourLines = [];
        final now = DateTime.now();

        // Add hours to the timeline
        for (int i = 0; i < 24; i++) {
          final String hourLabel = DateFormat('ha').format(
              DateTime(0, 0, 0, i));
          hourLines.add(SizedBox(
            width: hourWidth,
            child: HourLine(hourLabel: hourLabel, isCurrentHour: false),
          ));
        }

        // Calculate the position of the current time line
        final double currentHourOffset = (now.hour + now.minute / 60.0) *
            hourWidth;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(children: [
            Row(
              children: hourLines,
            ),
            Positioned(
              left: currentHourOffset,
              top: 0,
              bottom: 0,
              child: Container(
                width: 5.0,
                color: Colors.red,
              ),
            ),
          ],
          ),
        );
      },
    );
  }
}