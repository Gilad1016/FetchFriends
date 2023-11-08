class ParkItem {
  String id = '';
  String name = '';
  String mapsURL = '';

  ParkItem({required this.name, required this.mapsURL});

  factory ParkItem.fromJson(Map<String, dynamic> docDocument) {
    return ParkItem(
      name: docDocument['name'] as String,
      mapsURL: docDocument['mapsURL'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mapsURL': mapsURL,
    };
  }
}
