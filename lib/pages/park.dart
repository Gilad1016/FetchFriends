import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogy_park/widgets/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/data_provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/arrival_button.dart';
import '../models/dog_item.dart';

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
                  DogItem.fromMap(dogDocument.data() as Map<String, dynamic>
                  )..id = dogDocument.id)
              .toList();

          // Here, dogItems list contains all retrieved DogItem objects.

          return ListView.builder(
            itemCount: dogItems.length,
            itemBuilder: (context, index) {
              final dogItem = dogItems[index];
              // Use dogItem details to build your dog list item widget
              // For example, you could build a ListTile here with dog info and image
              return ListTile(
                title: Text(dogItem.name),
                subtitle: Text(dogItem.ownerUID),
                leading: (dogItem.imageUrl != null)
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(dogItem.imageUrl!),
                      )
                    : null,
                // Add any other widget elements you want based on your DogItem model
              );
            },
          );
        },
      ),

      floatingActionButton: const ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
