import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScrollableHourTimeline extends StatelessWidget {
  final int totalHours = 24;
  final double tileWidth = 80.0;

  const ScrollableHourTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int currentHour = now.hour;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: totalHours,
        itemBuilder: (context, index) {
          return TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.manual,
            lineXY: 0.7,
            isFirst: index == 0,
            isLast: index == totalHours - 1,
            indicatorStyle: IndicatorStyle(
              width: 10,
              color: index == currentHour ? Colors.red : Colors.grey,
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.grey,
              thickness: 2,
            ),
            afterLineStyle: const LineStyle(
              color: Colors.grey,
              thickness: 2,
            ),
            startChild: SizedBox(
              width: tileWidth,
              child: Center(
                child: Text('$index:00'),
              ),
            ),
            endChild: Container(
              width: tileWidth,
            ),
          );
        },
      ),
    );
  }
}
