import 'dart:io';

import 'package:flutter/material.dart';

import '../../../dog_management/dog_item.dart';
import '../../common/design/color_pallette.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/inputs/camera_form.dart';
import '../../common/widgets/inputs/custom_input.dart';

class DogCreateOrUpdate extends StatefulWidget {
  final DogItem dogItem;
  final VoidCallback onEditCancel;
  final void Function(DogItem) postDog;

  const DogCreateOrUpdate({
    required this.dogItem,
    required this.postDog,
    required this.onEditCancel,
    super.key,
  });

  @override
  State<DogCreateOrUpdate> createState() => _DogCreateOrUpdateState();
}

class _DogCreateOrUpdateState extends State<DogCreateOrUpdate> {
  late TextEditingController _dogController;
  String? _newImage;

  @override
  void initState() {
    super.initState();
    _dogController = TextEditingController(text: widget.dogItem.name);
  }

  // Update logic functions (replace with your actual update methods)
  Future<void> _updateDogName(String newName) async {
    // ... Update dog name with newName ...
  }

  Future<void> _updateDogImage(File? newImage) async {
    // ... Update dog image with newImage ...
  }

  @override
  Widget build(BuildContext context) {
    final onEditCancel = widget.onEditCancel;
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10, right: 60),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 5,
        ),
      ),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Camera form for image selection
            CameraForm(
              selectedImage: _newImage,
              onImageSelected: (String? image) {
                setState(() {
                  _newImage = image;
                });},
            ),
            const SizedBox(height: 20),
            CustomInputText(
              labelText: 'Name',
              hintText: 'Enter your dog\'s name',
              controller: _dogController,
              onChanged: (text) => setState(() {}),
            ),
            const SizedBox(height: 10),
            // Cancel and save buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () => onEditCancel(),
                  text: 'Cancel',
                ),
                const SizedBox(width: 10),
                CustomButton(
                  onPressed: () {
                    // Update dog name
                    _updateDogName(_dogController.text);
                    // Update dog image
                    _updateDogImage(_newImage != null ? File(_newImage!) : null);
                    // Post updated dog
                    widget.postDog(widget.dogItem);
                  },
                  text: 'Save',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
