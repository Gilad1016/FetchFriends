import 'package:dogy_park/design/color_pallette.dart';
import 'package:flutter/material.dart';

class ArrivalButton extends StatelessWidget {
  const ArrivalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/arrival'),
          backgroundColor: Colors.white,
          elevation: 0.0,
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
}
