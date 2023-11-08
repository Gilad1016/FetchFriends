import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dog_item.dart';
import 'data_provider.dart';

String loginKey = "5FD6G46SDF4GD64F1VG9SD68";
String onboardKey = "GD2G82CG9G82VDFGVD22DVG";

class AppStateProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange =
      StreamController<bool>.broadcast();
  late final dogProvider;

  bool _init = false;
  bool _loginState = false;
  bool _dogsLoaded = false;

  AppStateProvider(this.sharedPreferences);

  bool get loginState => _loginState;

  bool get init => _init;

  bool get dogsLoaded => _dogsLoaded;

  Stream<bool> get loginStateChange => _loginStateChange.stream;

  set loginState(bool state) {
    sharedPreferences.setBool(loginKey, state);
    _loginState = state;
    notifyListeners();
  }

  set init(bool value) {
    // sharedPreferences.setBool(onboardKey, value);
    _init = value;
    notifyListeners();
  }

  set dogsLoaded(bool value) {
    _dogsLoaded = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _loginState = sharedPreferences.getBool(loginKey) ?? false;
    dogProvider = DogProvider(FirebaseFirestore.instance, sharedPreferences);

    _init = true;
    if (_loginState) {
      List<DogItem>? myDogs = await dogProvider.getUserDogs(true);
      _dogsLoaded = (myDogs!.isNotEmpty)!;
    }
    notifyListeners();
  }
}
