import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state/states_utils.dart';

class AuthProvider {
  final StreamController<AppState> _onAuthStateChange =
  StreamController.broadcast();
  final sharedPreferences = SharedPreferences.getInstance();

  String? loginErrorMessage;

  Stream<AppState> get onAuthStateChange => _onAuthStateChange.stream;

  Future<String> register(String email, String password) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      sharedPreferences
          .then((value) => value.setString('token', credential.user!.uid));
      _onAuthStateChange.add(AppState.loggedIn);
      return "success";
    } on FirebaseAuthException catch (e) {
      loginErrorMessage = e.message ?? "An error occurred";
      return loginErrorMessage!;
    } catch (e) {
      loginErrorMessage = e.toString();
      return loginErrorMessage!;
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      sharedPreferences
          .then((value) => value.setString('token', credential.user!.uid));
      _onAuthStateChange.add(AppState.loggedIn);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          loginErrorMessage = 'The password is incorrect.';
          break;
        case 'invalid-email':
          loginErrorMessage = 'The email address is invalid.';
          break;
        case 'user-disabled':
          loginErrorMessage = 'The user account has been disabled.';
          break;
        case 'user-not-found':
          loginErrorMessage = 'The user account does not exist.';
          break;
        default:
          loginErrorMessage = 'An unexpected error occurred. \nerror code: ${e.code}';
      }
      return loginErrorMessage!;
    } catch (e) {
      loginErrorMessage = 'An unexpected error occurred.';
      return loginErrorMessage!;
    }
  }


  void logOut() {
    _onAuthStateChange.add(AppState.unauthenticated);
    sharedPreferences.then((value) => value.remove('token'));
  }

  Future<String> getMyToken() {
    return sharedPreferences.then((value) => value.getString('token') ?? "");
  }
}
