import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String loginKey = "5FD6G46SDF4GD64F1VG9SD68";
String onboardKey = "GD2G82CG9G82VDFGVD22DVG";

class AppProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange =
      StreamController<bool>.broadcast();
  bool _loginState = false;
  bool _init = false;

  AppProvider(this.sharedPreferences);

  bool get loginState => _loginState;

  bool get init => _init;

  Stream<bool> get loginStateChange => _loginStateChange.stream;

  set loginState(bool state) {
    sharedPreferences.setBool(loginKey, state);
    _loginState = state;
    notifyListeners();
  }

  set init(bool value) {
    sharedPreferences.setBool(onboardKey, value);
    _init = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _loginState = sharedPreferences.getBool(loginKey) ?? false;
    _init = true;

  }
}
