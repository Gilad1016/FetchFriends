import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dog_item.dart';

class DataProvider {
  final StreamController<bool> _onMyDogsChange =
  StreamController.broadcast();
  final FirebaseFirestore _firestore;
  final SharedPreferences _sharedPreferences;
  Stream<bool> get onMyDogsChange => _onMyDogsChange.stream;

  DataProvider(this._firestore, this._sharedPreferences);

  // uses firestore to query and return a list of dogs that belong to the user
  // if the user is not logged in, returns null
  // if the user is logged in but has no dogs, returns an empty list
  // save to shared preferences to avoid querying firestore every time
  Future<List<DogItem>?> getUserDogs(bool forceQuery) async {
    if (forceQuery || !_sharedPreferences.containsKey('user_dogs')) {
      String? userToken = _sharedPreferences.getString('token');
      await _loadUserDogsFromFirestore(userToken!);
    }

    final userDogsData = _sharedPreferences.getStringList('user_dogs');
    if (userDogsData == null) {
      return null;
    }
    return userDogsData.map((dogData) {
      print(dogData);
      final decodedDogData = Map<String, dynamic>.from(jsonDecode(dogData));
      return DogItem.fromJson(decodedDogData);
    }).toList();
  }

  //load all the dogs that has userToken from firestore and save them to shared preferences
  Future<void> _loadUserDogsFromFirestore(String userToken) async {
    final userDogsQuerySnapshot = await _firestore
        .collection('dogs')
        .where('ownerUID', isEqualTo: userToken)
        .get();

    final userDogs = userDogsQuerySnapshot.docs.map((dogDocumentSnapshot) {
      final dog = DogItem.fromJson(dogDocumentSnapshot.data());
      dog.id = dogDocumentSnapshot.id;
      return dog;
    }).toList();

    final userDogsData = userDogs.map((dog) => jsonEncode(dog.toJson())).toList();
    await _sharedPreferences.setStringList('user_dogs', userDogsData);
    _onMyDogsChange.add(true);
  }

  Future<void> addDog(DogItem dog) async {
    final dogDocumentReference = await _firestore.collection('dogs').add(dog.toJson());
    dog.id = dogDocumentReference.id;
    final userDogs = await getUserDogs(true);
    userDogs!.add(dog);
    final userDogsData = userDogs.map((dog) => jsonEncode(dog.toJson())).toList();
    await _sharedPreferences.setStringList('user_dogs', userDogsData);
    _onMyDogsChange.add(true);
  }
}
