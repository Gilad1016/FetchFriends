import 'dart:async';
import 'package:pocketbase/pocketbase.dart';

import 'Items/park_item.dart';

class ParkProvider {
  late final PocketBase pb;
  List<ParkItem> _parkItems = [];

  ParkProvider() {
    _initialize();
  }

  List<ParkItem> get parkItems => _parkItems;

  Future<void> _initialize() async {
    pb = PocketBase('http://127.0.0.1:8090/');
    await fetchParks();
  }

  Future<List<ParkItem>> fetchParks() async {
    final result = await pb.collection('parks').getFullList();
    _parkItems = result.map((record) => ParkItem.fromMap({
      'id': record.id,
      'name': record.data['name'],
      'mapsURL': record.data['mapsURL'],
    })).toList();
    return _parkItems;
  }
}
