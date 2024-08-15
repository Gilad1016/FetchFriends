import 'dart:async';
import 'package:fetch/dog_management/dog_item.dart';
import 'package:fetch/park/park_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';
import '../common/config.dart';
import 'Items/arrival_item.dart';

class ArrivalsProvider with ChangeNotifier {
  late final PocketBase pb;
  List<ArrivalItem> _arrivalItems = [];
  late ParkProvider _parkProvider;

  set parkProvider(ParkProvider parkProvider) {
    _parkProvider = parkProvider;
    notifyListeners();
  }

  ArrivalsProvider() {
    pb = PocketBase(pbAddress);
  }

  @override
  void dispose() {
    pb.collection('arrivals').unsubscribe('*');
    super.dispose();
  }

  List<ArrivalItem> get arrivalItems {
    final now = DateTime.now();
    final startTime = now.subtract(const Duration(hours: 4));
    final endTime = now.add(const Duration(hours: 20));

    return _arrivalItems.where((item) =>
    item.startTime.isAfter(startTime) &&
        item.startTime.isBefore(endTime)).toList();
  }

  Future<void> fetchArrivals() async {
    if (_parkProvider.currentPark.id.isEmpty) return;

    final result = await pb.collection('arrivals').getList(
      filter: 'start_time >= @todayStart && start_time <= @todayEnd'
          '&& at.id = "${_parkProvider.currentPark.id}"',
    );
    _arrivalItems = result.items.map((record) =>
        ArrivalItem.fromMap(record.id, record.data)).toList();
    notifyListeners();
  }

  Future<void> addArrival(DateTime dateTime,Duration duration,List<DogItem> dogs) async {
    for(int i = 0; i < dogs.length; i++) {
      final item = ArrivalItem(
        startTime: dateTime, parkId: _parkProvider.currentPark.id, dog: dogs[i].name);
      item.endTime = item.startTime.add(duration);
      print('Adding arrival: ${item.toMap()}');
      await pb.collection('arrivals').create(body: item.toMap());
    }
    fetchArrivals();
  }

  void subscribeToArrivals() {
    pb.collection('arrivals').subscribe('*', (event) {
      print('Arrival event: ${event.action}');
      switch (event.action) {
        case 'create':
          final newArrival =
          ArrivalItem.fromMap(event.record!.id, event.record!.data);
          if (newArrival.startTime.isAfter(DateTime.now().subtract(const Duration(hours: 24))) &&
              newArrival.startTime.isBefore(DateTime.now().add(const Duration(hours: 24)))) {
            _arrivalItems.add(newArrival);
          }
          break;
        case 'update':
          final updatedArrival =
          ArrivalItem.fromMap(event.record!.id, event.record!.data);
          _arrivalItems = _arrivalItems.map((item) {
            return item.id == updatedArrival.id ? updatedArrival : item;
          }).toList();
          break;
        case 'delete':
          _arrivalItems.removeWhere((item) => item.id == event.record!.id);
          break;
      }
      notifyListeners();
    });
  }
}
