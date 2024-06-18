import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/providers/app_state/app_state_provider.dart';
import '../common/widgets/custom_button.dart';
import 'dog_management.dart';
import '../common/widgets/top_bar/app_bar.dart';

class DogMngPage extends StatefulWidget {
  const DogMngPage({super.key});

  @override
  State<DogMngPage> createState() => _DogMngPageState();
}

class _DogMngPageState extends State<DogMngPage> {
  final _nameController = TextEditingController();
  File? _selectedImage;
  late AppStateProvider _appProvider;
  // late BackendService _backendService;

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);
    // _backendService = Provider.of<BackendService>(context, listen: false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _addDog() async {
    final name = _nameController.text;
    final image = _selectedImage;

    if (name.isEmpty) {
      return;
    }

    // final dogItem = DogItem(name: name, ownerUID: _appProvider.user!.uid);
    //
    // if (image != null) {
    //   final imageUrl = await _backendService.uploadDogImage(image, dogItem);
    //   dogItem.imageUrl = imageUrl;
    // }
    //
    // await _backendService.addDog(dogItem);
    // _appProvider.addDog(dogItem);
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Add Dog'),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            DogManagement(
              //TODO: fix the function
              // onCreateNewDog: () => {},
              dogItems: const [],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Add Dog',
              onPressed: _addDog,
            ),
          ])),
    );
  }
}
