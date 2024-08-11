import 'package:flutter/material.dart';

class HourLine extends StatelessWidget {
  final String hourLabel;
  final bool isCurrentHour;

  const HourLine({required this.hourLabel, required this.isCurrentHour, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(isCurrentHour ? "Now" : hourLabel),
        ),
        Expanded(
          child: Container(
            width: 2.0,
            color: isCurrentHour ? Colors.red : Colors.grey,
          ),
        ),
        Expanded(
          child: Container(
            width: 2.0,
            color: isCurrentHour ? Colors.red : Colors.grey,
          ),
        ),
      ],
    );
  }
}
