import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';
import 'Items/arrival_item.dart';

class ArrivalsProvider with ChangeNotifier {
  late final PocketBase pb;
  List<ArrivalItem> _arrivalItems = [];

  ArrivalsProvider() {
    _initialize();
  }

  List<ArrivalItem> get arrivalItems => _arrivalItems;

  void addArrivalItem(ArrivalItem item) {
    _arrivalItems.add(item);
    notifyListeners();
    // Save the new arrival to the database
    saveArrival(item);
  }

  Future<void> _initialize() async {
    pb = PocketBase('http://127.0.0.1:8090/');
    await fetchArrivals();
    _subscribeToArrivals();
  }

  void updateArrivalItem(ArrivalItem item) {
    _arrivalItems.removeWhere((element) => element.id == item.id);
    _arrivalItems.add(item);
    notifyListeners();
    // Save the updated arrival to the database
    saveArrival(item);
  }

  Future<void> deleteArrivalItem(String id) async {
    await pb.collection('arrivals').delete(id);
    _arrivalItems.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<List<ArrivalItem>> fetchArrivals() async {
    final result = await pb.collection('arrivals').getFullList();
    _arrivalItems = result.map((record) =>
        ArrivalItem.fromMap(record.id, record.data)
    ).toList();
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
          final newArrival = ArrivalItem.fromMap(event.record!.id, event.record!.data);
          _arrivalItems.add(newArrival);
          break;
        case 'update':
        // Record updated
          final updatedArrival = ArrivalItem.fromMap(event.record!.id, event.record!.data);
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
