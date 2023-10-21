class DogItem {
  String id;
  String name;
  String ownerName;
  int energyLevel;
  List<String> mustKnow;

  DogItem({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.energyLevel,
    required this.mustKnow,
  });


  Map<String,dynamic> toFirestoreMap(){
    return {
      'id': id,
      'name': name,
      'ownerName': ownerName,
      'energyLevel': energyLevel,
      'mustKnow': mustKnow,
    };
  }

  factory DogItem.fromFirestoreMap(Map<String,dynamic> map){
    return DogItem(
      id: map['id'],
      name: map['name'],
      ownerName: map['ownerName'],
      energyLevel: map['energyLevel'],
      mustKnow: List<String>.from(map['mustKnow']),
    );
  }
}