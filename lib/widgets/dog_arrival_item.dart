import 'package:flutter/material.dart';

import '../models/dog_item.dart';

class DogListItem extends StatelessWidget {
  final DogItem dogItem;
  final bool isHeMine;

  const DogListItem({super.key, required this.dogItem, required this.isHeMine});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (dogItem.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(dogItem.imageUrl!, width: 80, height: 80, fit: BoxFit.cover),
          ),
        const SizedBox(width: 10),
        Text(dogItem.name, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        if (isHeMine)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu icon click
            },
          ),
      ],
    );
  }
}
