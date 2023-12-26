import 'package:dogy_park/models/park_item.dart';
import 'package:dogy_park/providers/backend_service/backend_service.dart';
import 'package:dogy_park/widgets/top_bar/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/backend_service/auth_provider.dart';
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
  late final List<DogItem> dogData;
  late BackendService _backendService;
  late AuthProvider _authProvider;

  ParkItem park = ParkItem(
      name: 'Sokolov Garden',
      mapsURL: Uri.parse('https://maps.app.goo.gl/QrmnpJT3EBZEppEMA'));

  onStartUp(BuildContext context) async {
    _backendService.getDogs().then((data) {
      setState(() {
        dogData = data!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _backendService = Provider.of<BackendService>(context, listen: false);
    dogData = [];
    WidgetsBinding.instance.addPostFrameCallback((_) => onStartUp(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          titleText: 'Sokolov Garden', trailingWidget: SettingWidget()),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 28, right: 28),
        child: ListView.builder(
          itemCount: dogData.length,
          itemBuilder: (context, index) {
            final dogItem = dogData[index];
            return ArrivalTile(dogItem: dogItem);
          },
        ),
      ),
      floatingActionButton: const ArrivalButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
