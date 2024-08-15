import 'package:fetch/park/Items/park_item.dart';

class ArrivalItem {
  String id = '';
  DateTime startTime;
  DateTime endTime = DateTime.now();
  String parkId = '';
  ParkItem? park;
  String dog = '';
  int rowNum = 0;

  ArrivalItem(
      {required this.startTime, required this.parkId,required this.dog}) {
    endTime = startTime.add(const Duration(hours: 2));
  }

  factory ArrivalItem.fromMap(String id, Map<String, dynamic> docDocument) {
    ArrivalItem arr = ArrivalItem(
      startTime: DateTime.parse(docDocument['start_time'] as String),
      parkId: docDocument['at'] as String,
      dog: docDocument['of'] as String,
    );
    arr.id = id;
    arr.endTime = DateTime.parse(docDocument['end_time'] as String);
    return arr;
  }

  Map<String, dynamic> toMap() {
    return {
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'at': parkId,
      'of': dog,
    };
  }
}
