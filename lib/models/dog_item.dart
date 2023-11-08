class DogItem {
  String id = '';
  String name = '';
  String ownerEmail = '';
  String? imageUrl = '';

  DogItem({required this.name, required this.ownerEmail, this.imageUrl = ''});

  factory DogItem.fromJson(Map<String, dynamic> docDocument) {
    return DogItem(
      // get name from ref to doc in key 'dogRef' in relation document
      name: docDocument['name'] as String,
      ownerEmail: docDocument['ownerEmail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerEmail': ownerEmail,
    };
  }
}
