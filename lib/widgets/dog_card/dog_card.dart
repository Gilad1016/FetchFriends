import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dogy_park/design/color_pallette.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onPressed: onEditPressed ?? () {},
                  text: 'Edit 📝',
                ),
              ],
            ),
        ],
      ),
    );
  }
}
