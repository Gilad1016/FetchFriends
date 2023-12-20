import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/models/park_item.dart';
import 'dart:async';

import '../models/user_data.dart';

class DataProvider {
  final _db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

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

  Future<void> addDog(DogItem dog) async {
    final dogDocumentReference = await _db.collection('dogs').add(dog.toMap());

    dog.id = dogDocumentReference.id;
    try {
      final imageFile = File(dog.imageUrl!);
      final imageRef = storageRef.child('dogs/${dog.id}.jpg');
      await imageRef.putFile(imageFile);
      dog.imageUrl = await imageRef.getDownloadURL();
    } catch (e) {
      print(e);
    }

    updateDog(dog);
  }

  Future<void> updateDog(DogItem dog) async {
    await _db.collection('dogs').doc(dog.id).update(dog.toMap());
  }

  void deleteDog(DogItem dog) async {
    await _db.collection('dogs').doc(dog.id).delete();
  }

  Query getDogsAtParkRef(String parkId) {
    final dogsAtParkRef =
        _db.collection('dogs').where('arrival.parkId', isEqualTo: parkId);
    return dogsAtParkRef;
  }

  void addUserData(UserData userData) async {
    final userDataDocumentReference =
        await _db.collection('users_data').add(userData.toMap());
    userData.userToken = userDataDocumentReference.id;
  }

  // Future<List<ParkItem>?> getUserSavedParks(String userToken) async {
  //   final savedParksRef = _db
  //       .collection('users_data')
  //       .doc(userToken)
  //       .where('savedParksId', arrayContains: userToken);
  //
  //   final savedParks = savedParksRef.get().then((snapshot) {
  //     final parks = snapshot.docs.map((parkDocumentSnapshot) {
  //       final park = ParkItem.fromMap(parkDocumentSnapshot.data());
  //       park.id = parkDocumentSnapshot.id;
  //       return park;
  //     }).toList();
  //     return parks;
  //   });
  //   return await savedParks;
  // }

  void addPark(ParkItem park) async {
    final parkDocumentReference =
        await _db.collection('parks').add(park.toMap());
    park.id = parkDocumentReference.id;
  }

  void updatePark(ParkItem park) async {
    await _db.collection('parks').doc(park.id).update(park.toMap());
  }

  void deletePark(ParkItem park) async {
    await _db.collection('parks').doc(park.id).delete();
  }

  Future<List<ParkItem>> getParks() async {
    final parksRef = _db.collection('parks');

    final allParks = parksRef.get().then((snapshot) {
      final parks = snapshot.docs.map((parkDocumentSnapshot) {
        final park = ParkItem.fromMap(parkDocumentSnapshot.data());
        park.id = parkDocumentSnapshot.id;
        return park;
      }).toList();
      return parks;
    });
    return await allParks;
  }
}
