import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/providers/app_state/app_state_provider.dart';
// import 'package:pocketbase/pocketbase.dart';

import 'dog_item.dart';
class DogProvider extends ChangeNotifier {
  // late final PocketBase pb;
  late final AppStateProvider appStateProvider;
  List<DogItem> _dogItems = [];

  DogProvider() {
    _initialize();
  }

  List<DogItem> get dogItems => _dogItems;

  Future<void> _initialize() async {
    appStateProvider = AppStateProvider();
    // pb = PocketBase('http://127.0.0.1:8090/');
    await fetchDogs();
  }

  Future<void> fetchDogs() async {
    // final result = await pb.collection('dogs').getFullList();
    // _dogItems = result.map((record) => DogItem.fromMap({
    //   'id': record.id,
    //   'name': record.data['name'],
    //   'imageUrl': record.data['imageUrl'],
    //   'ownerUID': record.data['ownerUID'],
    // })).toList();
    final prefs = await SharedPreferences.getInstance();
    final dogsString = prefs.getString('dogs');
    if (dogsString != null) {
      final List<dynamic> dogsList = jsonDecode(dogsString);
      _dogItems = dogsList.map((dog) => DogItem.fromMap(dog)).toList();
    } else {
      _dogItems = [];
    }
    notifyListeners();
  }

  Future<void> _saveDogsToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final dogsString = jsonEncode(_dogItems.map((dog) => dog.toMap()).toList());
    await prefs.setString('dogs', dogsString);
  }

  Future<String> addDog(String name, String ownerUID) async {
    // final body = <String, dynamic>{
    //   "name": name,
    //   "ownerUID": ownerUID,
    // };
    // RecordModel dogData;
    // try {
    //   dogData = await pb.collection('dogs').create(body: body);
    //   final newDog = DogItem.fromMap({
    //     'id': dogData.id,
    //     'name': dogData.data['name'],
    //     'imageUrl': dogData.data['imageUrl'],
    //     'ownerUID': dogData.data['ownerUID'],
    //   });
    //   _dogItems.add(newDog);
    //   notifyListeners();
    // } catch (e) {
    //   print(e);
    //   return 'Error adding dog';
    // }
    final newDog = DogItem(id: DateTime.now().toString(), name: name);
    _dogItems.add(newDog);
    await _saveDogsToLocalStorage();
    notifyListeners();
    return 'success';
  }

  Future<String> deleteDog(String dogID) async {
    // try {
    //   await pb.collection('dogs').delete(dogID);
    //   _dogItems.removeWhere((dog) => dog.id == dogID);
    //   notifyListeners();
    // } catch (e) {
    //   print(e);
    //   return 'Error deleting dog';
    // }
    _dogItems.removeWhere((dog) => dog.id == dogID);
    await _saveDogsToLocalStorage();
    notifyListeners();
    return 'success';
  }

  Future<String> updateDog(String dogID, String name) async {
    // final body = <String, dynamic>{
    //   "name": name,
    // };
    // try {
    //   await pb.collection('dogs').update(dogID, body: body);
    //   final dogIndex = _dogItems.indexWhere((dog) => dog.id == dogID);
    //   if (dogIndex != -1) {
    //     _dogItems[dogIndex].name = name;
    //     notifyListeners();
    //   }
    // } catch (e) {
    //   print(e);
    //   return 'Error updating dog';
    // }
    final dogIndex = _dogItems.indexWhere((dog) => dog.id == dogID);
    if (dogIndex != -1) {
      _dogItems[dogIndex].name = name;
      await _saveDogsToLocalStorage();
      notifyListeners();
      return 'success';
    }
    return 'Dog not found';
  }
}
