// import 'dart:async';
// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../models/dog_item.dart';
//
// class DataProvider {
//   final StreamController<bool> _onMyDogsChange = StreamController.broadcast();
//   final FirebaseFirestore _firestore;
//   final SharedPreferences _sharedPreferences;
//
//   Stream<bool> get onMyDogsChange => _onMyDogsChange.stream;
//
//   DataProvider(this._firestore, this._sharedPreferences);
//
//   // uses firestore to query and return a list of dogs that belong to the user
//   // if the user is not logged in, returns null
//   // if the user is logged in but has no dogs, returns an empty list
//   // save to shared preferences to avoid querying firestore every time
//   StreamSubscription<List<DogItem>> getUserDogs() {
//     final userToken = _sharedPreferences.getString('user_token');
//     if (userToken == null) {
//       return List<DogItem>.empty();
//     }
//
//     return _firestore
//         .collection('dogs')
//         .where('ownerUID', isEqualTo: userToken)
//         .snapshots()
//         .map((snapshot) {
//       final userDogs = snapshot.docs.map((dogDocumentSnapshot) {
//         final dog = DogItem.fromJson(dogDocumentSnapshot.data());
//         dog.id = dogDocumentSnapshot.id;
//         return dog;
//       }).toList();
//
//       final userDogsData =
//           userDogs.map((dog) => jsonEncode(dog.toJson())).toList();
//       _sharedPreferences.setStringList('user_dogs', userDogsData);
//       _onMyDogsChange.add(true);
//       return userDogs;
//     }).listen((_) {});
//   }
//
//   //load all the dogs that has userToken from firestore and save them to shared preferences
//   Future<void> _loadUserDogsFromFirestore(String userToken) async {
//     final userDogsQuerySnapshot = await _firestore
//         .collection('dogs')
//         .where('ownerUID', isEqualTo: userToken)
//         .get();
//
//     final userDogs = userDogsQuerySnapshot.docs.map((dogDocumentSnapshot) {
//       final dog = DogItem.fromJson(dogDocumentSnapshot.data());
//       dog.id = dogDocumentSnapshot.id;
//       return dog;
//     }).toList();
//
//     final userDogsData =
//         userDogs.map((dog) => jsonEncode(dog.toJson())).toList();
//     await _sharedPreferences.setStringList('user_dogs', userDogsData);
//     _onMyDogsChange.add(true);
//   }
//
//   Future<void> addDog(DogItem dog) async {
//     final dogDocumentReference =
//         await _firestore.collection('dogs').add(dog.toJson());
//     dog.id = dogDocumentReference.id;
//     final userDogs = await getUserDogs(true);
//     userDogs.add(dog);
//     final userDogsData =
//         userDogs.map((dog) => jsonEncode(dog.toJson())).toList();
//     await _sharedPreferences.setStringList('user_dogs', userDogsData);
//     _onMyDogsChange.add(true);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/models/park_item.dart';
import 'dart:async';

class DataProvider {
  final _db = FirebaseFirestore.instance;

  Query getMyDogsRef(String userToken) {
    final myDogsRef =
        _db.collection('dogs').where('ownerUID', isEqualTo: userToken);
    return myDogsRef;
  }

  Future<List<DogItem>?> getMyDogs(String userToken) async {
    final myDogsRef =
        _db.collection('dogs').where('ownerUID', isEqualTo: userToken);

    final myDogs = myDogsRef.get().then((snapshot) {
      final userDogs = snapshot.docs.map((dogDocumentSnapshot) {
        final dog = DogItem.fromMap(dogDocumentSnapshot.data());
        dog.id = dogDocumentSnapshot.id;
        return dog;
      }).toList();
      return userDogs;
    });
    return await myDogs;
  }

  void addDog(DogItem dog) async {
    final dogDocumentReference = await _db.collection('dogs').add(dog.toMap());
    dog.id = dogDocumentReference.id;
  }

  void updateDog(DogItem dog) async {
    await _db.collection('dogs').doc(dog.id).update(dog.toMap());
  }

  void deleteDog(DogItem dog) async {
    await _db.collection('dogs').doc(dog.id).delete();
  }

  void addPark(ParkItem park) async {
    final parkDocumentReference =
        await _db.collection('parks').add(park.toJson());
    park.id = parkDocumentReference.id;
  }

  void updatePark(ParkItem park) async {
    await _db.collection('parks').doc(park.id).update(park.toJson());
  }

  void deletePark(ParkItem park) async {
    await _db.collection('parks').doc(park.id).delete();
  }

  Stream<List<ParkItem>> getParks() {
    final parksRef = _db.collection('parks');

    final parks = parksRef.snapshots().map((snapshot) {
      final parks = snapshot.docs.map((parkDocumentSnapshot) {
        final park = ParkItem.fromJson(parkDocumentSnapshot.data());
        park.id = parkDocumentSnapshot.id;
        return park;
      }).toList();
      return parks;
    });
    return parks;
  }
}
