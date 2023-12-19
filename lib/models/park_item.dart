class ParkItem {
  String id = '';
  String name = '';
  String mapsURL = '';
  // geoPoint location = geoPoint();


  ParkItem({required this.name, required this.mapsURL});

  factory ParkItem.fromMap(Map<String, dynamic> docDocument) {
    return ParkItem(
      name: docDocument['name'] as String,
      mapsURL: docDocument['mapsURL'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mapsURL': mapsURL,
    };
  }
}
