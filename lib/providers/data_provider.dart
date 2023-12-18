import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dogy_park/models/dog_item.dart';
import 'package:dogy_park/models/park_item.dart';
import 'dart:async';


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
