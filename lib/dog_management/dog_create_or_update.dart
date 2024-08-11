import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dog_management/dog_item.dart';
import '../common/widgets/custom_button.dart';
import 'dog_provider.dart';

//TODO: add delete functionality
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final dogProvider = Provider.of<DogProvider>(context, listen: false);
      if (widget.dogItem == null) {
        // Create new dog
        await dogProvider.addDog(_nameController.text, _imageUrlController.text);
      } else {
        // Update existing dog
        await dogProvider.updateDog(
          widget.dogItem!.id,
          _nameController.text,
          // _imageUrlController.text,
        );
      }
    }
    Navigator.pop(context);
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
          onPressed: () => Navigator.pop(context),
          text: 'Cancel',
        ),
        CustomButton(
          onPressed: _submitForm,
          text: widget.dogItem == null ? 'Create' : 'Update',
        ),
      ],
    );
  }
}
