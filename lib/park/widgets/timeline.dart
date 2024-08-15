import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Items/arrival_item.dart';
import '../arrivals_provider.dart';
import 'arrival/arrival_icon.dart';
import 'hour_line.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  static const double minHourWidth = 60;
  static const double maxHourWidth = 240;
  static const double dampingFactor = 0.1; // Smaller values make zoom less aggressive
  double hourWidth = 120; // Initially set to max

  late Timer _timer;
  DateTime _now = DateTime.now();
  late ArrivalsProvider _arrivalsProvider;
  late ScrollController _scrollController; // Add a ScrollController

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(); // Initialize the ScrollController

    // Update the current time every minute
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });

    // Scroll to the current time (red line) when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
  }

  List<ArrivalIcon> generateArrivalIcons(List<ArrivalItem> arrivals, double hourWidth) {
    arrivals.sort((a, b) => a.startTime.compareTo(b.startTime));

    List<ArrivalIcon> icons = [];

    for (int i = 0; i < arrivals.length; i++) {
      final currentArrival = arrivals[i];
      int maxRowNum = 0;
      for (int j = 0; j < i; j++) {
        final previousArrival = arrivals[j];
        if (currentArrival.startTime.isBefore(previousArrival.endTime) &&
            currentArrival.endTime.isAfter(previousArrival.startTime)) {
          maxRowNum = previousArrival.rowNum + 1;
        }
      }
      currentArrival.rowNum = maxRowNum;
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

  void _updateHourWidth(double scaleFactor) {
    setState(() {
      // Apply the damping factor to the scaleFactor to make the zoom less aggressive
      double adjustedScale = 1 + (scaleFactor - 1) * dampingFactor;
      hourWidth = (hourWidth * adjustedScale).clamp(minHourWidth, maxHourWidth);
    });

    // Scroll to the current time after zooming
    _scrollToCurrentTime();
  }

  void _scrollToCurrentTime() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double currentHourOffset = (4.5 + _now.minute / 60.0) * hourWidth;

    // Scroll to the position where the red line is centered on the screen
    _scrollController.animateTo(
      currentHourOffset - screenWidth / 4,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    _arrivalsProvider = Provider.of<ArrivalsProvider>(context);

    final List<Widget> hourLines = [];
    for (int i = 0; i < 24; i++) {
      final String hourLabel = DateFormat('ha')
          .format(DateTime(0, 0, 0, (i + _now.hour - 4) % 24));
      hourLines.add(SizedBox(
        width: hourWidth,
        child: HourLine(hourLabel: hourLabel),
      ));
    }

    final double currentHourOffset = (4.5 + _now.minute / 60.0) * hourWidth;

    return GestureDetector(
      onScaleUpdate: (details) {
        _updateHourWidth(details.scale);
      },
      child: SingleChildScrollView(
        controller: _scrollController, // Attach the ScrollController
        scrollDirection: Axis.horizontal,
        child: Stack(
          children: [
            Row(
              children: hourLines,
            ),
            Positioned(
              left: currentHourOffset,
              top: 0,
              bottom: 0,
              child: Container(
                width: 5.0,
                color: Colors.redAccent,
              ),
            ),
            for (final icon in generateArrivalIcons(_arrivalsProvider.arrivalItems, hourWidth))
              Positioned(
                left: ((icon.startTime.hour - _now.hour + 4.5) +
                    icon.startTime.minute / 60.0) *
                    hourWidth,
                top: 50 * (icon.rowNum + 1),
                child: icon,
              ),
          ],
        ),
      ),
    );
  }
}
