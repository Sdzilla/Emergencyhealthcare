import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum DialogType { base, form }

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future loginWithEmail(
      {@required String email, @required String password}) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail(
      {@required String email, @required String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<User> getCurrentUser() async {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser;
    } else
      return null;
  }

  Future logout() async {
    print('called');
    await _firebaseAuth.signOut();
  }
}
