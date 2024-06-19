import 'dart:io';

import 'package:Fetch/dog_management/dog_card/dog_card_hero.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/providers/app_state/app_state_provider.dart';
import '../common/widgets/custom_button.dart';
import 'dog_item.dart';
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

  // Future<void> _addDog() async {
  //   final name = _nameController.text;
  //   final image = _selectedImage;
  //
  //   if (name.isEmpty) {
  //     return;
  //   }
  //
  //   final dogItem = DogItem(name: name, ownerUID: _appProvider.user!.uid);
  //
  //   if (image != null) {
  //     final imageUrl = await _backendService.uploadDogImage(image, dogItem);
  //     dogItem.imageUrl = imageUrl;
  //   }
  //
  //   await _backendService.addDog(dogItem);
  //   _appProvider.addDog(dogItem);
  //   // GoRouter.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Dogies'),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            //TODO: add text to explain what this page
            //is for, make it dynamic
            // DogManagement(
            //   //TODO: fix the function
            //   // onCreateNewDog: () => {},
            //   dogItems: const [],
            // ),
            DogHero(
                dogItem: new DogItem(name: '', ownerUID: '1234'),
                isEditing: true),
            const SizedBox(height: 20),
            //TODO: add button to move to next page when dogs are added
          ])),
    );
  }
}
