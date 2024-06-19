import 'dart:io';

import 'package:Fetch/dog_management/dog_card/dog_card_hero.dart';
import 'package:Fetch/dog_management/dog_provider.dart';
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
  late DogProvider _dogProvider;


  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);
    _dogProvider = Provider.of<DogProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onCreateNewDog() {

  }

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
