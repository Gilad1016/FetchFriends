import 'dart:io';

import 'package:dogy_park/widgets/inputs/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../design/color_pallette.dart';
import '../../models/dog_item.dart';
import '../custom_button.dart';

class EditDogCard extends StatefulWidget {
  final DogItem dogItem;
  final VoidCallback onEditCancel;

  const EditDogCard({
    required this.dogItem,
    required this.onEditCancel,
    super.key,
  });

  @override
  _EditDogCardState createState() => _EditDogCardState(dogItem, onEditCancel);
}

class _EditDogCardState extends State<EditDogCard> {
  // Edited values
  String _editedName = '';
  File? _newImage;

  _EditDogCardState(DogItem dogItem, VoidCallback onEditCancel);

  // Update logic functions (replace with your actual update methods)
  Future<void> _updateDogName(String newName) async {
    // ... Update dog name with newName ...
  }

  Future<void> _updateDogImage(File? newImage) async {
    // ... Update dog image with newImage ...
  }

  @override
  Widget build(BuildContext context) {
    final dogItem = widget.dogItem;
    final onEditCancel = widget.onEditCancel;
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
          // Editable text field for name
          CustomInputText(
            hintText: 'Enter your dog\'s name',
            labelText: 'Name',
            controller: TextEditingController(text: dogItem.name),
          ),
          const SizedBox(height: 10),
          // Image with edit options
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(dogItem.imageUrl!),
                minRadius: 100,
                maxRadius: 100,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  onPressed: () async {
                    // Choose new image from camera or gallery
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() => _newImage = File(pickedFile.path));
                    }
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Cancel and save buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                onPressed: () => onEditCancel(),
                text: 'Cancel',
              ),
              const SizedBox(width: 10),
              CustomButton(
                onPressed: () async {
                  await _updateDogName(_editedName);
                  if (_newImage != null) await _updateDogImage(_newImage);
                  // Close edit mode and navigate back
                  onEditCancel();
                },
                text: 'Save',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
