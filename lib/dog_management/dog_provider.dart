import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dog_item.dart';
class DogProvider extends ChangeNotifier {
  List<DogItem> _dogItems = [];

  DogProvider() {
    _initialize();
  }

  List<DogItem> get dogItems => _dogItems;

  Future<void> _initialize() async {
    await fetchDogs();
  }

  Future<void> fetchDogs() async {
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

  Future<String> addDog(String name) async {
    final newDog = DogItem(id: DateTime.now().toString(), name: name);
    _dogItems.add(newDog);
    await _saveDogsToLocalStorage();
    notifyListeners();
    return 'success';
  }

  //TODO: fix state if no dogs
  Future<String> deleteDog(String dogID) async {
    _dogItems.removeWhere((dog) => dog.id == dogID);
    await _saveDogsToLocalStorage();
    notifyListeners();
    return 'success';
  }

  Future<String> updateDog(String dogID, String name) async {
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
