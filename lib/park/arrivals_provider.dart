import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';
import '../common/config.dart';
import 'Items/arrival_item.dart';

class ArrivalsProvider with ChangeNotifier {
  late final PocketBase pb;
  List<ArrivalItem> _arrivalItems = [];

  ArrivalsProvider() {
    _initialize();
  }

  List<ArrivalItem> get arrivalItems {
    final now = DateTime.now();
    final startTime = now.subtract(const Duration(hours: 4));
    final endTime = now.add(const Duration(hours: 20));

    return _arrivalItems
        .where((item) =>
    item.startTime.isAfter(startTime) &&
        item.startTime.isBefore(endTime))
        .toList();
  }

  Future<void> _initialize() async {
    pb = PocketBase(pbAddress);
    await fetchArrivals();
    _subscribeToArrivals();
  }

  Future<List<ArrivalItem>> fetchArrivals() async {
    final result = await pb.collection('arrivals').getFullList();
    _arrivalItems = result
        .map((record) => ArrivalItem.fromMap(record.id, record.data))
        .toList();
    notifyListeners();
    return _arrivalItems;
  }

  Future<void> saveArrival(ArrivalItem item) async {
    final recordId = await pb.collection('arrivals').create(body: item.toMap());
    print(recordId);
    // Update the arrival list after saving
    fetchArrivals();
  }

  void _subscribeToArrivals() {
    // Subscribe to real-time updates for the 'arrivals' collection
    pb.collection('arrivals').subscribe('*', (event) {
      switch (event.action) {
        case 'create':
        // New record created
          final newArrival =
          ArrivalItem.fromMap(event.record!.id, event.record!.data);
          _arrivalItems.add(newArrival);
          break;
        case 'update':
        // Record updated
          final updatedArrival =
          ArrivalItem.fromMap(event.record!.id, event.record!.data);
          _arrivalItems = _arrivalItems.map((item) {
            return item.id == updatedArrival.id ? updatedArrival : item;
          }).toList();
          break;
        case 'delete':
        // Record deleted
          _arrivalItems.removeWhere((item) => item.id == event.record!.id);
          break;
      }
      notifyListeners(); // Notify listeners after every event
    });
  }

  @override
  void dispose() {
    // Unsubscribe from real-time updates when the provider is disposed
    pb.collection('arrivals').unsubscribe('*');
    super.dispose();
  }
}
