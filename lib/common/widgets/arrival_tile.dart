import 'package:flutter/material.dart';

import '../../dog_management/dog_item.dart';
import '../design/color_pallette.dart';

class ArrivalTile extends StatelessWidget {
  final DogItem dogItem;

  const ArrivalTile({
    required this.dogItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: TextButton(
        onPressed: () => {}, // Update to your actual onPressed handler
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: AppColors.accentColor, // Border color
              width: 5, // Outline width
            ),
          ),
        ),
        child: Row(
          children: [
            (dogItem.imageUrl != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage(dogItem.imageUrl!),
                  )
                : const SizedBox(width: 50), // Placeholder if no image
            const SizedBox(width: 10),
            Text(
              dogItem.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: AppColors.primaryColor, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
