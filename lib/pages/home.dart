import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogy_park/models/park_item.dart';
import 'package:dogy_park/widgets/top_bar/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';
import '../widgets/top_bar/app_bar.dart';
import '../widgets/arrival/arrival_button.dart';
import '../models/dog_item.dart';
import '../widgets/arrival_tile.dart';

class ParkHomePage extends StatefulWidget {
  const ParkHomePage({super.key});

  @override
  State<ParkHomePage> createState() => _ParkHomePageState();
}

class _ParkHomePageState extends State<ParkHomePage> {
  late Query dogData = FirebaseFirestore.instance.collection('dogs');
  ParkItem park = ParkItem(
      name: 'Sokolov Garden',
      mapsURL: Uri.parse('https://maps.app.goo.gl/QrmnpJT3EBZEppEMA'));

  onStartUp(BuildContext context) async {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final parks = await dataProvider.getParks();
    // final userToken = authProvider.getMyToken();
    dogData = dataProvider.getDogsAtParkRef(parks[0].id);
    //dataProvider.getMyDogsRef(await userToken);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(
          titleText: 'Sokolov Garden', trailingWidget: SettingWidget()),
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
