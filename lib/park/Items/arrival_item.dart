import 'package:Fetch/park/Items/park_item.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../dog_management/dog_item.dart';

class ArrivalItem {
  DateTime startTime;
  DateTime endTime = DateTime.now();
  String parkId = '';
  String dogId = '';
  ParkItem? park;
  DogItem? dog;

  ArrivalItem(
      {required this.startTime, required this.parkId, required this.dogId, this.park, this.dog}) {
    endTime = startTime.add(const Duration(hours: 2));
  }

  factory ArrivalItem.fromMap(Map<String, dynamic> docDocument) {
    print(docDocument);
    ArrivalItem arr = ArrivalItem(
      startTime: DateTime.parse(docDocument['start_time'] as String),
      parkId: docDocument['at'] as String,
      dogId: docDocument['of'] as String,
    );
    arr.endTime = DateTime.parse(docDocument['end_time'] as String);
    return arr;
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'parkId': park?.id ?? '',
      'dogId': dog?.id ?? '',
    };
  }
}
