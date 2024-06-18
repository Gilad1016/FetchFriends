import 'package:Fetch/park/park_item.dart';

class ArrivalItem {
  DateTime time;
  ParkItem? park;
  String parkId = '';

  ArrivalItem({required this.time, required this.parkId, this.park});

  factory ArrivalItem.fromMap(Map<String, dynamic> docDocument) {
    return ArrivalItem(
      time: docDocument['time'] as DateTime,
      parkId: docDocument['parkId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'parkId': parkId,
    };
  }
}
