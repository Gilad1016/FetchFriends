import 'package:fetch/common/providers/app_state/app_state_provider.dart';
import 'package:fetch/dog_management/widgets/dog_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../common/providers/router/routes_utils.dart';
import '../common/widgets/custom_button.dart';
import 'dog_item.dart';
import '../common/widgets/top_bar/app_bar.dart';
import 'dog_create_or_update.dart';
import 'widgets/add_dog_button.dart';
import 'dog_provider.dart';

class DogMngPage extends StatefulWidget {
  const DogMngPage({super.key});

  @override
  State<DogMngPage> createState() => _DogMngPageState();
}

class _DogMngPageState extends State<DogMngPage> {
  final _nameController = TextEditingController();
  late AppStateProvider _appProvider;

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppStateProvider>(context, listen: false);
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
      await _appProvider.revalidateUserState();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'Dogies'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                      GoRouter.of(context).pushNamed(AppPage.parkHome.toName);
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
