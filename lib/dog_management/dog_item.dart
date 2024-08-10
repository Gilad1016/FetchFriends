class DogItem {
  String id = '';
  String name = '';
  String? imageUrl;

  DogItem(
      {required this.name,
      this.imageUrl});

  factory DogItem.fromMap(Map<String, dynamic> docDocument) {
    assert(docDocument['name'] != null);
    assert(docDocument['ownerUID'] != null);
    return DogItem(
      name: docDocument['name'] as String,
      imageUrl: docDocument['imageUrl'] == null
          ? null
          : docDocument['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl?.toString(),
    };
  }
}
