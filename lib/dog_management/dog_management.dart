import 'package:flutter/material.dart';

import 'dog_card/dog_card_hero.dart';
import 'dog_item.dart';

class DogManagement extends StatelessWidget {
  final List<DogItem> dogItems;
  final bool initCreateNew;

  const DogManagement({
    this.dogItems = const [],
    this.initCreateNew = false,
    super.key,
  });

  void onCreateNewDog() {
    // Add the logic to create a new dog item and add it to the list
    DogItem newDog = DogItem(name: '', ownerUID: '',); // Update with your model
    dogItems.add(newDog);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dogItems.length + (initCreateNew ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == dogItems.length) {
                  return ListTile(
                    title: const Text('Create New Dog'),
                    trailing: const Icon(Icons.add),
                    onTap: () => onCreateNewDog(),
                  );
                } else {
                  return DogHero(
                    dogItem: dogItems[index],
                    // Pass necessary functions for editing/deleting if needed
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
