import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:thoughts/services/api/info_user_api_provider.dart';

class UserRepository {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final InfoUserProvider _infoUserProvider = InfoUserProvider();

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<User?> registerWithEmailAndPassword(String email, String password, String name) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _infoUserProvider.createUserData(result.user!.uid, email, name);
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