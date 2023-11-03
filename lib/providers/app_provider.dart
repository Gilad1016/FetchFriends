import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String loginKey = "5FD6G46SDF4GD64F1VG9SD68";
String onboardKey = "GD2G82CG9G82VDFGVD22DVG";

class AppProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange = StreamController<bool>.broadcast();
  bool _loginState = false;
  bool _landing = false;

  AppProvider(this.sharedPreferences);

  bool get loginState => _loginState;
  bool get landing => _landing;
  Stream<bool> get loginStateChange => _loginStateChange.stream;

  set loginState(bool state) {
    sharedPreferences.setBool(loginKey, state);
    _loginState = state;
    notifyListeners();
  }

  set landing(bool value) {
    sharedPreferences.setBool(onboardKey, value);
    _landing = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _landing = sharedPreferences.getBool(onboardKey) ?? false;
    _loginState = sharedPreferences.getBool(loginKey) ?? false;
    // check if user is logged in from shared preferences and update login state
    if (sharedPreferences.containsKey(loginKey)) {
      _loginState = sharedPreferences.getBool(loginKey)!;
    }
    _loginStateChange.add(_loginState); // Notify the stream when initializing

  }
}
