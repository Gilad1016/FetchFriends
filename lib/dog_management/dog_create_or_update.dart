import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart'; // Assuming you're using the PocketBase client package

import '../../dog_management/dog_item.dart';
import '../common/design/color_pallette.dart';
import '../common/widgets/custom_button.dart';

class DogCreateOrUpdate extends StatefulWidget {
  final DogItem? dogItem;

  const DogCreateOrUpdate({this.dogItem, super.key});

  @override
  _DogCreateOrUpdateState createState() => _DogCreateOrUpdateState();
}

class _DogCreateOrUpdateState extends State<DogCreateOrUpdate> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _imageUrlController;
  final PocketBase pb = PocketBase('http://your-pocketbase-url'); // Replace with your PocketBase URL

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.dogItem?.name ?? '');
    _imageUrlController = TextEditingController(text: widget.dogItem?.imageUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveDog() async {
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     if (widget.dogItem == null) {
    //       // Create new dog
    //       final record = await pb.collection('dogs').create({
    //         'name': _nameController.text,
    //         'imageUrl': _imageUrlController.text,
    //       });
    //       print('Dog created: ${record.id}');
    //     } else {
    //       // Update existing dog
    //       final record = await pb.collection('dogs').update(
    //         widget.dogItem!.id,
    //         {
    //           'name': _nameController.text,
    //           'imageUrl': _imageUrlController.text,
    //         },
    //       );
    //       print('Dog updated: ${record.id}');
    //     }
    //     Navigator.pop(context, true); // Return true to indicate success
    //   } catch (e) {
    //     print('Error: $e');
    //     // Handle error appropriately
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dogItem == null ? 'Create Dog' : 'Update Dog'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          onPressed: () => Navigator.pop(context), // Cancel action
          text: 'Cancel',
        ),
        CustomButton(
          onPressed: _saveDog,
          text: widget.dogItem == null ? 'Create' : 'Update',
        ),
      ],
    );
  }
}
