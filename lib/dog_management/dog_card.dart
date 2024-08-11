import 'package:flutter/material.dart';

import '../../dog_management/dog_item.dart';
import '../common/design/color_pallette.dart';
import '../common/widgets/custom_button.dart';
import 'dog_create_or_update.dart'; // Import the component you want to display in an overlay

class DogCard extends StatelessWidget {
  final DogItem dogItem;

  const DogCard({
    required this.dogItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(dogItem.imageUrl != null)
              CircleAvatar(
            backgroundImage: NetworkImage(dogItem.imageUrl!),
            minRadius: 100,
            maxRadius: 100,
          ),
          const SizedBox(height: 20),
          Text(
            dogItem.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: AppColors.primaryColor, // Text color
            ),
          ),
          const SizedBox(height: 10),
          // Add conditional widget for pencil emoji if isEditable
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
                  text: '📝',
                ),
              ],
            ),
        ],
      ),
    );
  }
}