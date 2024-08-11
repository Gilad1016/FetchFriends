import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late DogProvider _dogProvider;

  @override
  void initState() {
    super.initState();
    _dogProvider = Provider.of<DogProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _showCreateOrUpdateDogDialog() async {
    final newDog = await showDialog<DogItem>(
      context: context,
      builder: (context) => const DogCreateOrUpdate(),
    );

    if (newDog != null) {
      _dogProvider.addDog(newDog.name, 'ownerUID'); // Replace 'ownerUID' with actual ownerUID
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
              child: Consumer<DogProvider>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: 10,
                      children: [
                        for (var dog in provider.dogItems)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: DogCard(
                              dogItem: dog,
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
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Consumer<DogProvider>(
              builder: (context, provider, child) {
                return Visibility(
                  visible: provider.dogItems.isNotEmpty,
                  child: CustomButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
