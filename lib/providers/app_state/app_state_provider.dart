import 'dart:async';

import 'package:dogy_park/providers/app_state/states_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_provider.dart';

String loginKey = "5FD6G46SDF4GD64F1VG9SD68";

class AppStateProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange =
      StreamController<bool>.broadcast();

  AppState _appState = AppState.init;

  AppStateProvider(this.sharedPreferences);

  Stream<bool> get loginStateChange => _loginStateChange.stream;

  AppState get state => _appState;

  set state(AppState value) {
    print("changed state: $value");
    _appState = value;
    notifyListeners();
  }

  Future<void> onAppStart(context) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('token') != null) {
      _appState = AppState.loggedIn;
      final userToken = sharedPreferences.getString('token');
      final myDogs = await Provider.of<DataProvider>(context, listen: false)
          .getMyDogs(userToken!);
      print("myDogs: $myDogs");
      assert(myDogs != null, "Failed to load dogs");
      if (myDogs!.isNotEmpty) {
        _appState = AppState.loggedInWithDogs;
      }
    } else {
      _appState = AppState.unauthenticated;
    }

    notifyListeners();
  }
}
