import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogy_park/widgets/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/data_provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/arrival_button.dart';
import '../models/dog_item.dart';
import '../widgets/arrival_tile.dart';

class ParkPage extends StatefulWidget {
  const ParkPage({super.key});

  @override
  State<ParkPage> createState() => _ParkPageState();
}

class _ParkPageState extends State<ParkPage> {
  late Query dogData = FirebaseFirestore.instance.collection('dogs');

  onStartUp(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final userToken = authProvider.getMyToken();
    dogData = dataProvider.getMyDogsRef(await userToken);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  @override
  Widget build(BuildContext context) {
    // Get dog data from DataProvider

    return Scaffold(
      appBar: const CustomAppBar(
          titleText: 'Sokolov Garden', trailingWidget: SettingWidget()),
      // Replace the existing body with this:
      body: StreamBuilder<QuerySnapshot>(
        stream: dogData.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Handle error case
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            // Handle loading case
            return const Center(child: CircularProgressIndicator());
          }

          final dogDocuments =
              snapshot.data!.docs; // List of QueryDocumentsSnapshot
          final dogItems = dogDocuments
              .map((dogDocument) =>
                  DogItem.fromMap(dogDocument.data() as Map<String, dynamic>)
                    ..id = dogDocument.id)
              .toList();

          // Here, dogItems list contains all retrieved DogItem objects.

          return Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 28, right: 28),
              child: ListView.builder(
                itemCount: dogItems.length,
                itemBuilder: (context, index) {
                  final dogItem = dogItems[index];
                  return ArrivalTile(dogItem: dogItem);
                },
              ));
        },
      ),

      floatingActionButton: const ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
