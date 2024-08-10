import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/providers/app_state/app_state_provider.dart';
import '../common/widgets/custom_button.dart';
import 'dog_card.dart';
import 'dog_item.dart';
import '../common/widgets/top_bar/app_bar.dart';
import 'dog_create_or_update.dart';
import 'add_dog_button.dart';
import 'dog_provider.dart';

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
  final List<DogItem> _dogItems = [];

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);
    _dogProvider = Provider.of<DogProvider>(context, listen: false);
    _dogItems.add(DogItem(name: 'Buddy'));
    _dogItems.add(DogItem(name: 'Rex'));
    _dogItems.add(DogItem(name: 'Luna'));
    _dogItems.add(DogItem(name: 'Max'));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onCreateNewDog(DogItem dog) {
    setState(() {
      _dogItems.add(dog);
    });
    // _dogProvider.addDog(dog);
  }

  Future<void> _showCreateOrUpdateDogDialog() async {
    final newDog = await showDialog<DogItem>(
      context: context,
      builder: (context) => const DogCreateOrUpdate(),
    );

    if (newDog != null) {
      _onCreateNewDog(newDog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Dogies'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10, // To add space between each widget
                  children: [
                    for (var dog in _dogItems)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: DogCard(
                          dogItem: dog,
                          onEditPressed: () {
                            //TODO: add edit functionality
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AddDogButton(
                        onPressed: _showCreateOrUpdateDogDialog,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: _dogItems.isNotEmpty,
              child: CustomButton(
                text: 'Next',
                onPressed: () {
                  Navigator.pushNamed(context, '/next_page');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
