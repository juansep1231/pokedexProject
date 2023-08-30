import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;

  User? get user => _user;

  Future<void> signInUserPassword(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _user = credential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print("error al inicier sesion: $e");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
