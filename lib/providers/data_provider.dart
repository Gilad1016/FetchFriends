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

  // void deleteDog(DogItem dog) async {
  //   await _db.collection('dogs').doc(dog.id).delete();
  // }

  Query getDogsAtParkRef(String parkId) {
    final dogsAtParkRef =
        _db.collection('dogs').where('arrival.parkId', isEqualTo: parkId);
    return dogsAtParkRef;
  }

  // void addUserData(UserData userData) async {
  //   final userDataDocumentReference =
  //       await _db.collection('users_data').add(userData.toMap());
  //   userData.userToken = userDataDocumentReference.id;
  // }

  Future<List<ParkItem>> getUserSavedParks(String userToken) async {
    final savedParksDoc =
        FirebaseFirestore.instance.collection('users_data').doc(userToken);
    final snapshot = await savedParksDoc.get();

    if (!snapshot.exists) {
      throw Exception('User data does not exist');
    }

    final savedParkIds =
        (snapshot.data()!['savedParksId'] as List).cast<String>();

    final parksQuery = FirebaseFirestore.instance.collection('parks');
    final parksSnapshot = await parksQuery
        .where(FieldPath.documentId, whereIn: savedParkIds)
        .get();

    final parkItems = <ParkItem>[];
    for (final parkDoc in parksSnapshot.docs) {
      final parkItem = ParkItem.fromMap(parkDoc.data());
      parkItems.add(parkItem);
    }

    return parkItems;
  }

  // void addPark(ParkItem park) async {
  //   final parkDocumentReference =
  //       await _db.collection('parks').add(park.toMap());
  //   park.id = parkDocumentReference.id;
  // }
  //
  // void updatePark(ParkItem park) async {
  //   await _db.collection('parks').doc(park.id).update(park.toMap());
  // }
  //
  // void deletePark(ParkItem park) async {
  //   await _db.collection('parks').doc(park.id).delete();
  // }

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

  Query getParksRef() {
    final parksRef = _db.collection('parks');
    return parksRef;
  }

  Future<List<ParkItem>> searchParks(
      String searchString, GeoPoint userLocation) async {
    Query<Map<String, dynamic>> parkQuery =
        FirebaseFirestore.instance.collection('parks');

    //magic fix because of firestore bug
    // searchString = '"$searchString"';
    if (searchString.isNotEmpty) {
      parkQuery = parkQuery.where('name', isGreaterThanOrEqualTo: searchString);
      parkQuery = parkQuery.where('name', isLessThanOrEqualTo: '$searchString\uf8ff');
    }

    //TODO: use geoflutterfire to query by distance
    // const radius = 10000; // Adjust radius based on your desired search area
    // parkQuery = parkQuery.orderBy('location', distance: userLocation, radius: radius);


    // Limit to first 15 documents
    parkQuery = parkQuery.limit(15);

    final snapshot = await parkQuery.get();

    // Use parkItem map to convert documents to ParkItems
    final parkItems =
        snapshot.docs.map((doc) => ParkItem.fromMap(doc.data())).toList();

    return parkItems;
  }
}
