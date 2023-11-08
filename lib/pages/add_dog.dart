import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dog_item.dart';
import '../providers/data_provider.dart';
import '../widgets/app_bar.dart';

class AddDogPage extends StatefulWidget {
  const AddDogPage({super.key});

  @override
  State<AddDogPage> createState() => _AddDogPageState();
}

class _AddDogPageState extends State<AddDogPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = image != null ? File(image.path) : null;
    });
  }

  void _submitForm(context) async {
    final dogName = _nameController.text;

    if (dogName.isEmpty) {
      return;
    }

    final dog = DogItem(
      name: dogName,
      imageUrl: _selectedImage != null ? _selectedImage!.path : null,
      ownerEmail: '',
    );

    final sharedPreferences = await SharedPreferences.getInstance();

    final dataProvider =
        DataProvider(FirebaseFirestore.instance, sharedPreferences);

    await dataProvider.addDog(dog);

    GoRouter.of(context).pushReplacement('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          titleText: 'Add a Dog',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Dog Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dog name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: _selectedImage == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 60,
                          color: Colors.grey,
                        )
                      : ClipOval(
                          child: Image.file(
                            _selectedImage!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm(context);
                  }
                },
                child: const Text('Add Dog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
