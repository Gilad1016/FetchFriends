import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/providers/app_state/app_state_provider.dart';
import 'package:pocketbase/pocketbase.dart';

// TODO: show incorrect password error message
// TODO: add forget password support
// TODO: add email verification support
// TODO: add social login support
class AuthProvider {
  late final PocketBase _pb;
  late final AppStateProvider _appStateProvider;

  AuthProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _appStateProvider = AppStateProvider();
    final prefs = await SharedPreferences.getInstance();

    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
      clear: () async => prefs.remove('pb_auth'),
    );

    _pb = PocketBase('http://127.0.0.1:8090/', authStore: store);
    refresh();
  }

  Future<String> login(String email, String password) async {
    RecordAuth authData;
    try {
      authData =
          await _pb.collection('users').authWithPassword(email, password);
    } catch (e) {
      return 'Incorrect email or password';
    }
    if (authData.token == "") {
      return 'Incorrect email or password';
    }
    _appStateProvider.revalidateUserState();
    return 'success';
  }

  Future<String> register(
      String email, String password, String passwordConfirm) async {
    final body = <String, dynamic>{
      "email": email,
      "password": password,
      "passwordConfirm": passwordConfirm,
    };
    RecordModel authData;
    try {
      authData = await _pb.collection('users').create(body: body);
    } catch (e) {
      print(e);
      return 'Error creating account';
    }
    if (authData.data == "") {
      //TODO: check token is valid
      return 'Error creating account';
    }
    _appStateProvider.revalidateUserState();
    return 'success';
  }

  void logOut() {
    _pb.authStore.clear();
  }

  Future<void> refresh() async {
    if (!_pb.authStore.isValid) {
      print('authStore is not valid');
      logOut();
      return;
    }
    final authData = await _pb.collection('users').authRefresh();
  }
}
