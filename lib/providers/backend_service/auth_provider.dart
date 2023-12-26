import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../app_state/states_utils.dart';

class AuthProvider {
  static const backendUrl = 'http://127.0.0.1:8080';

  final StreamController<AppState> _onAuthStateChange =
      StreamController.broadcast();
  final sharedPreferences = SharedPreferences.getInstance();
  String? loginErrorMessage;

  AuthProvider();

  Future<String?> get token => sharedPreferences.then((value) => value.getString('token'));

  Stream<AppState> get onAuthStateChange => _onAuthStateChange.stream;

  Future<String> login(String email, String password) async {
    try {
      // final credential =
      //     await pb.collection('users').authWithPassword(email, password);
      // print(credential.toString());
      // sharedPreferences
      //     .then((value) => value.setString('token', pb.authStore.token));
      _onAuthStateChange.add(AppState.loggedIn);
      return "success";
    } catch (e) {
      loginErrorMessage = e.toString();
      return loginErrorMessage!;
    }
  }

  // Future<String> register(String email, String password) async {
  //   try {
  //     final body = <String, dynamic>{
  //       'email': email,
  //       'password': password,
  //     };
  //     // final credential = pb.collection('users').create(body: body);
  //
  //     //TODO: check if credential is null
  //     //TODO: check if sharedPreference is needed
  //     // sharedPreferences
  //     //     .then((value) => value.setString('token', pb.authStore.token));
  //     _onAuthStateChange.add(AppState.loggedIn);
  //     return "success";
  //   } on ClientException catch (e) {
  //     throw e.message;
  //   } catch (e) {
  //     loginErrorMessage = 'An unexpected error occurred.';
  //     return loginErrorMessage!;
  //   }
  // }

  void logOut() {
    // pb.authStore.clear();
    _onAuthStateChange.add(AppState.unauthenticated);
    sharedPreferences.then((value) => value.remove('token'));
  }

  Future<String> getMyToken() {
    return sharedPreferences.then((value) => value.getString('token') ?? "");
  }

  // Future<String> login(String email, String password) async {
  //   var url = Uri.parse('$backendUrl/auth/token');
  //   var body = convert.json.encode({"username": email, "password": password});
  //   var response = await http
  //       .post(url, body: body, headers: {"Content-Type": "application/json"});
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     return jsonResponse; // Return access token or other response data
  //   } else {
  //     throw Exception("Login failed"); // Handle login error appropriately
  //   }
  // }

  Future<String> register(String email, String password) async {
    var url = Uri.parse('$backendUrl/auth/');
    var body = convert.json.encode({"email": email, "password": password});
    var response = await http
        .post(url, body: body, headers: {"Content-Type": "application/json"});

    var responseBody = convert.json.decode(response.body);

    if (response.statusCode == 200) {
      sharedPreferences
          .then((value) => value.setString('token', responseBody["access_token"]));
      _onAuthStateChange.add(AppState.loggedIn);
      return "success"; // Return access token or other response data
    } else {
      throw Exception(
          "Registration failed: $responseBody"); // Handle registration error
    }
  }
}
