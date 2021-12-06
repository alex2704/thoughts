import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on PlatformException catch(e) {
      throw Exception(e.toString());
    }
  }

  Future signOut() async {
    await _fAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = _fAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    return _fAuth.currentUser;
  }
}