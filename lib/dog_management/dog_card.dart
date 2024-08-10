import 'package:flutter/material.dart';

import '../../dog_management/dog_item.dart';
import '../common/design/color_pallette.dart';
import '../common/widgets/custom_button.dart';
import 'dog_create_or_update.dart'; // Import the component you want to display in an overlay

class DogCard extends StatelessWidget {
  final DogItem dogItem;
  final VoidCallback? onEditPressed;

  const DogCard({
    required this.dogItem,
    required this.onEditPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dogItem.name,
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: AppColors.primaryColor, // Text color
            ),
          ),
          const SizedBox(height: 10),
          (dogItem.imageUrl != null)
              ? CircleAvatar(
            backgroundImage: NetworkImage(dogItem.imageUrl!),
            minRadius: 100,
            maxRadius: 100,
          )
              : const SizedBox(width: 50), // Placeholder if no image
          const SizedBox(height: 20),
          // Add conditional widget for pencil emoji if isEditable
          if (onEditPressed != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => DogCreateOrUpdate(dogItem: dogItem),
                    );
                  },
                  text: 'Edit 📝',
                ),
              ],
            ),
        ],
      ),
    );
  }
}