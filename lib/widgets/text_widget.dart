import 'package:flutter/material.dart';

import '../design/color_pallette.dart';

class TextWidget extends StatelessWidget {
  final String headerText;
  final String subheaderText;

  const TextWidget({super.key,
    required this.headerText,
    required this.subheaderText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            headerText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
          child: Text(
            subheaderText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
