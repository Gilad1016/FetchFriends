import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/providers/auth_provider.dart';
import 'package:dogy_park/providers/data_provider.dart';
import 'package:dogy_park/providers/router/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';
import '../widgets/back_button.dart';
import '../widgets/dog_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return FutureBuilder<List<DogItem>?>(
      future: authProvider
          .getMyToken()
          .then((token) => dataProvider.getMyDogs(token)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle error case
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          // Handle loading case
          return const Center(child: CircularProgressIndicator());
        }

        final myDogs = snapshot.data!;

        return Scaffold(
          appBar: const CustomAppBar(
            titleText: 'My Profile',
            leadingWidget: BackWidget(),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 28, right: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: myDogs.length,
                    itemBuilder: (context, index) {
                      final dog = myDogs[index];
                      return DogTile(
                        dogItem: dog,
                        onPressed: () {
                          // appStateProvider.setDog(dog);
                          // GoRouter.of(context).pushNamed(AppPage.dog.toName);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                GoRouter.of(context).pushNamed(AppPage.addDog.toName),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
