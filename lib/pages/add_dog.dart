import 'dart:io';

import 'package:dogy_park/providers/app_state/app_state_provider.dart';
import 'package:dogy_park/providers/auth_provider.dart';
import 'package:dogy_park/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/dog_item.dart';
import '../providers/app_state/states_utils.dart';
import '../providers/data_provider.dart';
import '../widgets/top_bar/app_bar.dart';

class AddDogPage extends StatefulWidget {
  const AddDogPage({super.key});

  @override
  State<AddDogPage> createState() => _AddDogPageState();
}

class _AddDogPageState extends State<AddDogPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _selectedImage;
  late AppStateProvider _appProvider;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (dogName.isEmpty) {
      return;
    }

    await Provider.of<DataProvider>(context, listen: false).addDog(
      DogItem(
        name: dogName,
        imageUrl: _selectedImage?.path,
        ownerUID: await authProvider.getMyToken(),
      ),
    );


  }

  void test() {
    _appProvider.state = AppState.loggedInWithDogs;
    GoRouter.of(context).pushReplacement('/');

  }
  //TODO: delete and use edit profile logic
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
              const SizedBox(height: 32.0),
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
              const SizedBox(height: 32.0),
              //TODO: create a generic custom input widget
              // EmailInput(controller: _nameController),
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
              const SizedBox(height: 32.0),
              CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _submitForm(context);
                    test();
                  }
                },
                text: 'Add Dog',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
