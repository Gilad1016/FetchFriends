import 'dart:async';

import 'package:Fetch/common/providers/app_state/states_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user_data.dart';

class AppStateProvider with ChangeNotifier {
  late final SharedPreferences _sharedPreferences;

  AppState _appState = AppState.init;
  final UserData _userData = UserData(
    userToken: '',
    dogIds: [],
  );

  AppStateProvider(){
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
    // final myDogs = await _dataProvider.getMyDogs(_userData.userToken);
    // if (myDogs!.isNotEmpty) {
    //   _appState = AppState.loggedInWithDogs;
    //   _userData.dogIds = myDogs.map((dog) => dog.id).toList();
    //   _userData.dogItems = myDogs;
    //   return true;
    // }
    final prefs = await SharedPreferences.getInstance();
    final dogsString = prefs.getString('dogs');
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
