import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../design/color_pallette.dart';

class BackWidget extends StatelessWidget {
  final Function? action;

  const BackWidget({super.key, this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (action != null) {
          action!();
        } else {
          Navigator.pop(
              context); // Navigate back if no custom action is provided
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 20,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
