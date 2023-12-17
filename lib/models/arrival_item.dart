import 'package:dogy_park/models/park_item.dart';

class ArrivalItem {
  late String id;
  late int time;
  ParkItem? park;

  ArrivalItem(
      {required this.time,
        this.park});

  factory ArrivalItem.fromMap(Map<String, dynamic> docDocument) {
    return ArrivalItem(
      time: docDocument['time'] as int,
      park: docDocument['park'] == null
          ? null
          : ParkItem.fromJson(docDocument['park'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'park': park?.toJson(),
    };
  }
}
