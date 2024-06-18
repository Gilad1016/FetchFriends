import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/providers/app_state/states_utils.dart';
import 'package:pocketbase/pocketbase.dart';

// TODO: show incorrect password error message
// TODO: add forget password support
// TODO: add email verification support
// TODO: add social login support
class AuthProvider {
  final sharedPreferences = SharedPreferences.getInstance();
  final pb = PocketBase('http://127.0.0.1:8090/');

  final StreamController<AppState> _onAuthStateChange =
      StreamController.broadcast();

  AuthProvider();

  Stream<AppState> get onAuthStateChange => _onAuthStateChange.stream;

  Future<void> login(String email, String password) async {
    final authData =
        await pb.collection('users').authWithPassword(email, password);
    sharedPreferences
        .then((value) => value.setString('token', pb.authStore.token));
    _onAuthStateChange.add(AppState.loggedIn);
  }

  Future<void> register(
      String email, String password, String passwordConfirm) async {
    final body = <String, dynamic>{
      "email": email,
      "password": password,
      "passwordConfirm": passwordConfirm,
    };

    final record = await pb.collection('users').create(body: body);
    sharedPreferences
        .then((value) => value.setString('token', pb.authStore.token));
    _onAuthStateChange.add(AppState.loggedIn);
  }

  void logOut() {
    _onAuthStateChange.add(AppState.unauthenticated);
    sharedPreferences.then((value) => value.remove('token'));
  }

  Future<void> refresh() async {
    if (!pb.authStore.isValid) {
      logOut();
      return;
    }
    final authData = await pb.collection('users').authRefresh();
  }
}
