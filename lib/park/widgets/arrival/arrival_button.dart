import 'package:flutter/material.dart';
import '../../../common/design/color_pallette.dart';
import 'arrival_popup.dart';

class ArrivalButton extends StatefulWidget {
  const ArrivalButton({super.key});

  @override
  State<ArrivalButton> createState() => _ArrivalButtonState();
}

class _ArrivalButtonState extends State<ArrivalButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => _showArrivalPopup(context),
          backgroundColor: AppColors.backgroundColor,
          elevation: 4.0,
          shape: const CircleBorder(
            side: BorderSide(color: AppColors.secondaryColor, width: 5),
          ),
          child: const Text(
            '🐾',
            style: TextStyle(
              fontSize: 30,
              color: AppColors.primaryColor, // Text color
            ),
          ),
        ),
      ),
    );
  }

  void _showArrivalPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          content: ArrivalPopup(
            onConfirm: (dateTime, duration) {
              Navigator.of(context).pop();
              // Handle the confirmed data here
            },
          ),
        );
      },
    );
  }
}
