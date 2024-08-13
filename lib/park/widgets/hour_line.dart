import 'package:flutter/material.dart';

class HourLine extends StatelessWidget {
  final String hourLabel;

  const HourLine({required this.hourLabel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(hourLabel),
        ),
        Expanded(
          child: Container(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Container(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
