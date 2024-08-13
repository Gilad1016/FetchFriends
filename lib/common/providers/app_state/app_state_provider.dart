import 'dart:async';

import 'package:fetch/common/providers/app_state/states_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  AppState _appState = AppState.init;

  AppState get state => _appState;

  set state(AppState value) {
    if (_appState != value) {
      _appState = value;
      notifyListeners();
    }
  }

  Future<void> updateMyDogs() async {
    final prefs = await SharedPreferences.getInstance();
    final dogsString = prefs.getString('dogs');
    if (dogsString != null) {
      state = AppState.knownUser;
    } else {
      state = AppState.newUser;
    }
  }

  Future<void> revalidateUserState() async {
    await updateMyDogs();
  }
}
