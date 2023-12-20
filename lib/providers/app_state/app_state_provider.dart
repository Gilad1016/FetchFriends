import 'dart:async';

import 'package:dogy_park/providers/app_state/states_utils.dart';
import 'package:dogy_park/providers/location_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_data.dart';
import '../data_provider.dart';

String loginKey = "5FD6G46SDF4GD64F1VG9SD68";

class AppStateProvider with ChangeNotifier {
  late final SharedPreferences _sharedPreferences;
  final StreamController<bool> _loginStateChange =
      StreamController<bool>.broadcast();
  late DataProvider _dataProvider;


  AppState _appState = AppState.init;
  final UserData _userData = UserData(
    userToken: '',
    dogIds: [],
    savedParksId: [],
  );

  AppStateProvider(this._sharedPreferences, this._dataProvider);

  Stream<bool> get loginStateChange => _loginStateChange.stream;

  AppState get state => _appState;

  set state(AppState value) {
    print("changed state: $value");
    _appState = value;
    notifyListeners();
  }

  Future<bool> updateLoginState() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userToken = sharedPreferences.getString('token') ?? '';

    if (userToken.isNotEmpty) {
      _appState = AppState.loggedIn;
      _userData.userToken = userToken;
      return true;
    }
    return false;
  }

  Future<bool> updateLocationState() async {
    final LocationProvider locationProvider = LocationProvider();
    if (await locationProvider.isLocationReady()) {
      return true;
    }

    _appState = AppState.noLocationPermission;
    return false;
  }

  Future<bool> updateMyDogs() async {
    final myDogs = await _dataProvider.getMyDogs(_userData.userToken);
    if (myDogs!.isNotEmpty) {
      _appState = AppState.loggedInWithDogs;
      _userData.dogIds = myDogs.map((dog) => dog.id).toList();
      _userData.dogItems = myDogs;
      return true;
    }
    return false;
  }

  Future<void> onAppStart() async {
    _appState = AppState.unauthenticated;

    if (!await updateLoginState()) {
      notifyListeners();
      return;
    }

    if (!await updateLocationState()) {
      notifyListeners();
      return;
    }

    // final dataProvider = Provider.of<DataProvider>(context, listen: false);

    if (!await updateMyDogs()) {
      notifyListeners();
      return;
    }

    notifyListeners();
    // final savedParks = await Provider.of<DataProvider>(context, listen: false)
    //     .getSavedParks(userToken);
  }
}
