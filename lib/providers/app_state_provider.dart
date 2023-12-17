import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_provider.dart';

String loginKey = "5FD6G46SDF4GD64F1VG9SD68";

class AppStateProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange =
      StreamController<bool>.broadcast();
  // final StreamController<bool> _dogsLoadedChange =
  //     StreamController<bool>.broadcast();

  bool _init = false;
  bool _loginState = false;
  bool _userHasDogs = false;

  AppStateProvider(this.sharedPreferences);

  bool get init => _init;
  bool get loginState => _loginState;
  bool get userHasDogs => _userHasDogs;

  Stream<bool> get loginStateChange => _loginStateChange.stream;

  get loading => _init && !_loginState;

  set loginState(bool state) {
    sharedPreferences.setBool(loginKey, state);
    _loginState = state;
    notifyListeners();
  }

  set init(bool value) {
    _init = value;
    notifyListeners();
  }

  set userHasDogs(bool value) {
    _userHasDogs = value;
    notifyListeners();
  }

  Future<void> onAppStart(context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _loginState = sharedPreferences.getBool(loginKey) ?? false;

    if (_loginState) {
      final userToken = sharedPreferences.getString('token');
      final myDogs = await Provider.of<DataProvider>(context, listen: false).getMyDogs(userToken!);
      print("myDogs: $myDogs");
      assert(myDogs != null, "Failed to load dogs");
      _userHasDogs = myDogs!.isNotEmpty;
    }

    _init = true;
    notifyListeners();
  }
}
