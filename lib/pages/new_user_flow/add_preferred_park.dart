import 'package:dogy_park/models/park_item.dart';
import 'package:dogy_park/widgets/inputs/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';
import '../../providers/location_provider.dart';
import '../../widgets/park_tile.dart';
import '../../widgets/top_bar/app_bar.dart';

class AddPreferredParkPage extends StatefulWidget {
  const AddPreferredParkPage({super.key});

  @override
  State<AddPreferredParkPage> createState() => _AddPreferredParkPageState();
}

class _AddPreferredParkPageState extends State<AddPreferredParkPage> {
  final _searchTextController = TextEditingController();
  List<Widget> _searchResults = [];
  bool _showNextButton = false;
  // late final DataProvider _dataProvider;
  late final ParkItem _selectedPark;
  late final LocationProvider _locationProvider;

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      setState(() {
        _showNextButton = _searchTextController.text.isNotEmpty;
      });
    });
    // _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _locationProvider = LocationProvider();
    _locationProvider.getLocation();
  }

  Future<void> _onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _searchResults.clear();
        _showNextButton = false;
      });
      return;
    }

    // final searchLower = text.toLowerCase();
    // final parks = await _dataProvider.searchParks(
    //     text, _locationProvider.locationData);
    List<Widget> parkTiles = [];
    // for (var park in parks) {
    //   parkTiles.add(ParkTile(
    //     parkItem: park,
    //     onSavePark: (park) => _onParkSelected(park),
    //   ));
    // }
    setState(() {
      _searchResults = parkTiles;
      _showNextButton = text.isNotEmpty;
    });
  } //(park) => _onParkSelected(park), // Use ParkItem object

  void _onParkSelected(ParkItem park) {
    print('Park selected: ${park.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Choose Preferred Park',
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomInputText(
                  controller: _searchTextController,
                  hintText: 'Search for parks',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchTextController.clear();
                        _searchResults.clear();
                        _showNextButton = false;
                      });
                    },
                  ),
                  onChanged: _onSearchTextChanged,
                  labelText: 'Search for parks',
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) => _searchResults[index],
                  ),
                )
              ])),
    );
  }
}
