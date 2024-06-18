// import 'dart:async';
//
// import 'package:dogy_park/models/user_data.dart';
// import 'package:location/location.dart';
// import 'package:pocketbase/pocketbase.dart';
//
// import '../models/dog_item.dart';
// import '../models/park_item.dart';
//
// class DataProvider {
//   late PocketBase pb;
//
//   DataProvider({required this.pb});
//
//   Future<ResultList<RecordModel>> getMyDogsRef(String userToken) {
//     final myDogsRef =
//         pb.collection('dogs').getList(filter: 'ownerUID=$userToken');
//     return myDogsRef;
//   }
//
//   Future<List<DogItem>?> getMyDogs(String userToken) async {
//     final myDogsList =
//         await pb.collection('dogs').getList(filter: 'ownerUID=$userToken');
//
//     final myDogs =
//         myDogsList.items.map((dog) => DogItem.fromMap(dog.toJson())).toList();
//     return myDogs;
//   }
//
//   Future<void> addDog(DogItem dog) async {
//     await pb.collection('dogs').create(body: dog.toMap());
//
//     //TODO: handle image upload and id set
//     // try {
//     //   final imageFile = File(dog.imageUrl!);
//     //   final imageRef = storageRef.child('dogs/${dog.id}.jpg');
//     //   await imageRef.putFile(imageFile);
//     //   dog.imageUrl = await imageRef.getDownloadURL();
//     // } catch (e) {
//     //   print(e);
//     // }
//     //
//     // updateDog(dog);
//   }
//
//   Future<void> updateDog(DogItem dog) async {
//     await pb.collection('dogs').update(dog.id, body: dog.toMap());
//   }
//
// // void deleteDog(DogItem dog) async {
// //   await _db.collection('dogs').doc(dog.id).delete();
// // }
//
//   Future<ResultList<RecordModel>> getDogsAtParkRef(String parkId) {
//     final dogsAtParkRef =
//         pb.collection('dogs').getList(filter: 'arrival.parkId=$parkId');
//     return dogsAtParkRef;
//   }
//
// // void addUserData(UserData userData) async {
// //   final userDataDocumentReference =
// //       await _db.collection('users_data').add(userData.toMap());
// //   userData.userToken = userDataDocumentReference.id;
// // }
//
//   //TODO: handle no park returned
//   Future<List<ParkItem>> getUserSavedParks(String userToken) async {
//     final userDoc = await pb
//         .collection('users_data')
//         .getOne(userToken, expand: 'savedParksId');
//
//     final user = UserData.fromMap(userDoc.toJson());
//
//     final parksJson = await pb.collection('parks').getList(
//           filter: user.savedParksId.map((id) => 'id="$id"').join("||"),
//         );
//
//     final parkItems = <ParkItem>[];
//     for (final parkDoc in parksJson.items) {
//       final parkItem = ParkItem.fromMap(parkDoc.toJson());
//       parkItems.add(parkItem);
//     }
//
//     return parkItems;
//   }
//
// // void addPark(ParkItem park) async {
// //   final parkDocumentReference =
// //       await _db.collection('parks').add(park.toMap());
// //   park.id = parkDocumentReference.id;
// // }
// //
// // void updatePark(ParkItem park) async {
// //   await _db.collection('parks').doc(park.id).update(park.toMap());
// // }
// //
// // void deletePark(ParkItem park) async {
// //   await _db.collection('parks').doc(park.id).delete();
// // }
//
//   Future<List<ParkItem>> getParks() async {
//     final parksJson = await pb.collection('parks').getFullList();
//     final parkItems = <ParkItem>[];
//
//     for (final parkDoc in parksJson) {
//       final parkItem = ParkItem.fromMap(parkDoc.toJson());
//       parkItems.add(parkItem);
//     }
//
//     return parkItems;
//   }
//
//   RecordService getParksRef() {
//     final parksRef = pb.collection('parks');
//     return parksRef;
//   }
//
//   Future<List<ParkItem>> searchParks(
//       String searchString, LocationData userLocation) async {
//     late final Future<ResultList<RecordModel>> parkQuery;
//
//     if (searchString.isNotEmpty) {
//       parkQuery = pb
//           .collection('parks')
//           .getList(page: 1, perPage: 20, filter: 'name ~ $searchString');
//     } else {
//       parkQuery = pb.collection('parks').getList();
//     }
//
//     // const radius = 10000; // Adjust radius based on your desired search area
//     // parkQuery = parkQuery.orderBy('location', distance: userLocation, radius: radius);
//
//     final snapshot = await parkQuery;
//
//     final parks = snapshot.items
//         .map((parkDocumentSnapshot) =>
//             ParkItem.fromMap(parkDocumentSnapshot.toJson()))
//         .toList();
//
//     return parks;
//   }
// }
