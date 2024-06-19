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
    await updateLoginState();
    await updateMyDogs();
    notifyListeners();
  }

  AppState get state => _appState;

  set state(AppState value) {
    _appState = value;
    notifyListeners();
  }

  Future<void> updateLoginState() async {
    print('updateLoginState');
    final userToken = _sharedPreferences.getString('pb_auth') ?? '';

    if (userToken.isNotEmpty) {
      if (_appState == AppState.unauthenticated || _appState == AppState.init) {
        _appState = AppState.loggedIn;
        _userData.userToken = userToken;
      }
      return;
    }
    _appState = AppState.unauthenticated;
  }

  // Future<bool> updateLocationState() async {
  //   final LocationProvider locationProvider = LocationProvider();
  //   if (await locationProvider.isLocationReady()) {
  //     return true;
  //   }
  //
  //   _appState = AppState.noLocationPermission;
  //   return false;
  // }

  Future<bool> updateMyDogs() async {
    // final myDogs = await _dataProvider.getMyDogs(_userData.userToken);
    // if (myDogs!.isNotEmpty) {
    //   _appState = AppState.loggedInWithDogs;
    //   _userData.dogIds = myDogs.map((dog) => dog.id).toList();
    //   _userData.dogItems = myDogs;
    //   return true;
    // }
    return false;
  }

  Future<void> revalidateUserState() async {
    print(_appState);
    updateLoginState();
    updateMyDogs();
    print(_appState);
    notifyListeners();
  }
}
