import 'dart:async';
import 'package:Fetch/park/Items/arrival_item.dart';
import 'package:pocketbase/pocketbase.dart';

class ArrivalsProvider {
  late final PocketBase pb;
  List<ArrivalItem> _arrivalItems = [];

  ArrivalsProvider() {
    _initialize();
  }

  List<ArrivalItem> get arrivalItems => _arrivalItems;

  Future<void> _initialize() async {
    pb = PocketBase('http://127.0.0.1:8090/');
    await fetchArrivals();
  }

  Future<List<ArrivalItem>> fetchArrivals() async {
    final result = await pb.collection('arrivals').getFullList();
    print(result);
    _arrivalItems = result.map((record) =>
      ArrivalItem.fromMap(record.data)
        // ArrivalItem.fromMap(record.data)
      // {
      //   'startTime': record.data['startTime'],
      //   'endTime': record.data['endTime'],
      //   'at': record.data['at'],
      //   'of': record.data['of'],
      // },
    ).toList();
    return _arrivalItems;
  }
}
