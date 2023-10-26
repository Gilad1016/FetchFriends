import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print("Error registering: $e");
      }
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      return user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if the user is signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
