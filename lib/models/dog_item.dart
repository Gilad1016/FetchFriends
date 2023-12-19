import 'arrival_item.dart';

ArrivalItem? getValidArrival(Map<String, dynamic> docDocument) {
  if (docDocument['arrival'] == null) {
    return null;
  }
  ArrivalItem arrivalItem =
      ArrivalItem.fromMap(docDocument['arrival'] as Map<String, dynamic>);
  if (arrivalItem.time
          .compareTo(DateTime.now().subtract(const Duration(hours: 1))) <
      0) {
    return null;
  }
  return arrivalItem;
}

class DogItem {
  String id = '';
  String name = '';
  String ownerUID = '';
  String? imageUrl;
  ArrivalItem? arrival;

  DogItem(
      {required this.name,
      required this.ownerUID,
      this.imageUrl,
      this.arrival});

  factory DogItem.fromMap(Map<String, dynamic> docDocument) {
    assert(docDocument['name'] != null);
    assert(docDocument['ownerUID'] != null);
    return DogItem(
      name: docDocument['name'] as String,
      ownerUID: docDocument['ownerUID'] as String,
      imageUrl: docDocument['imageUrl'] == null
          ? null
          : docDocument['imageUrl'] as String,
      arrival: getValidArrival(docDocument),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ownerUID': ownerUID,
      'imageUrl': imageUrl?.toString(),
      'arrival': arrival?.toMap(),
    };
  }
}
