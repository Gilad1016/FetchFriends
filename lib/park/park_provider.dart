import 'dart:async';
import 'package:Fetch/park/park_item.dart';
import 'package:flutter/foundation.dart';
import '../common/providers/app_state/app_state_provider.dart';
import 'package:pocketbase/pocketbase.dart';

class ParkProvider extends ChangeNotifier {
  late final PocketBase pb;
  late final AppStateProvider appStateProvider;
  List<ParkItem> _parkItems = [];

  ParkProvider() {
    _initialize();
  }

  List<ParkItem> get parkItems => _parkItems;

  Future<void> _initialize() async {
    appStateProvider = AppStateProvider();
    pb = PocketBase('http://127.0.0.1:8090/');
    await fetchParks();
  }

  Future<void> fetchParks() async {
    final result = await pb.collection('parks').getFullList();
    _parkItems = result.map((record) => ParkItem.fromMap({
      'id': record.id,
      'name': record.data['name'],
      'mapsURL': record.data['mapsURL'],
    })).toList();
    notifyListeners();
  }
}
