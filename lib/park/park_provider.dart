import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';
import 'Items/park_item.dart';
import '../common/config.dart';

class ParkProvider with ChangeNotifier {
  late final PocketBase pb;
  List<ParkItem> _parkItems = [];
  late ParkItem _currentPark = ParkItem(id: '', name: '', mapsURL: Uri.parse(''));

  ParkProvider() {
    _initialize();
  }

  List<ParkItem> get parkItems => _parkItems;

  ParkItem get currentPark => _currentPark;

  Future<void> _initialize() async {
    pb = PocketBase(pbAddress);
    await fetchParks();
  }

  Future<List<ParkItem>> fetchParks() async {
    final result = await pb.collection('parks').getFullList();
    _parkItems = result.map((record) => ParkItem.fromMap({
      'id': record.id,
      'name': record.data['name'],
      'mapsURL': record.data['mapsURL'],
    })).toList();
    _currentPark = _parkItems.first;
    notifyListeners();
    return _parkItems;
  }

  void nextPark() {
    final currentIndex = _parkItems.indexOf(_currentPark);
    final nextIndex = (currentIndex + 1) % _parkItems.length;
    _currentPark = _parkItems[nextIndex];
    notifyListeners();
  }

  void previousPark() {
    final currentIndex = _parkItems.indexOf(_currentPark);
    final previousIndex = (currentIndex - 1 + _parkItems.length) % _parkItems.length;
    _currentPark = _parkItems[previousIndex];
    notifyListeners();
  }
}
