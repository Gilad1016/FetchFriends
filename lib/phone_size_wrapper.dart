import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'common/design/color_pallette.dart';

class PhoneSizeWrapper extends StatelessWidget {
  final Widget child;

  const PhoneSizeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Check if the platform is web
    if (kIsWeb) {
      return Center(
        child: Container(
          width: 375, // iPhone width
          height: 667, // iPhone height
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            border: Border.all(color: AppColors.primaryColor, width: 5),
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow( // Add a shadow
                blurRadius: 12,
                color: Colors.black54,
              ),
            ],
          ),
          child: child,
        ),
      );
    } else {
      return child;
    }
  }
}
