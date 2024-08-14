
class ParkItem {
  String id = '';
  String name = '';
  Uri mapsURL = Uri.parse('');
  // int latitude = 0;
  // int longitude = 0;

  ParkItem({required this.name, required this.mapsURL, required this.id});

  factory ParkItem.fromMap(Map<String, dynamic> docDocument) {
    //
    // final point1 = LatLng(latitude1, longitude1);
    // final point2 = LatLng(latitude2, longitude2);
    //
    // final distance = Distance()
    //     .as(LengthUnit. Kilometer, point1, point2);
    //
    // print('Distance: ${distance.toString()} km');

    return ParkItem(
      id: docDocument['id'] as String,
      name: docDocument['name'] as String,
      mapsURL: Uri.parse(docDocument['mapsURL'] as String),
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
