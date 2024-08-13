import 'package:flutter/material.dart';
import '../../../common/design/color_pallette.dart';

class ArrivalIcon extends StatelessWidget {
  final String text;
  final double width;
  final DateTime startTime;
  final int rowNum;

  const ArrivalIcon({
    super.key,
    required this.text,
    required this.width,
    required this.startTime,
    required this.rowNum,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      child: Container(
        width: width,
        height: 60,
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.accentColor,
            width: 5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: AppColors.primaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
