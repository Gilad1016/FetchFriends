import 'dart:async';

import 'package:fetch/common/providers/app_state/states_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  late final SharedPreferences _sharedPreferences;

  AppState _appState = AppState.init;

  AppStateProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await updateMyDogs();
    notifyListeners();
  }

  AppState get state => _appState;

  set state(AppState value) {
    _appState = value;
    notifyListeners();
  }

  Future<void> updateMyDogs() async {
    final dogsString = _sharedPreferences.getString('dogs');
    if (dogsString != null) {
      _appState = AppState.knownUser;
    } else {
      _appState = AppState.newUser;
    }
  }

  Future<void> revalidateUserState() async {
    updateMyDogs();
    notifyListeners();
  }
}
